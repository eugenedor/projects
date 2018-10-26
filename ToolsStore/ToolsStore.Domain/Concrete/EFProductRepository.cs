﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ToolsStore.Domain.Abstract;
using ToolsStore.Domain.Entities;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;


namespace ToolsStore.Domain.Concrete
{
    public class EFProductRepository : IProductRepository
    {
        private EFDbContext context = new EFDbContext();

        public IQueryable<RS_PRODUCT> Prdcts
        {
            get { return context.RS_PRODUCT; }
        }

        public IQueryable<SK_EQUIPMENT> Equipments
        {
            get { return context.SK_EQUIPMENT; }
        }

        public IQueryable<CT_CATEGORY> Categories
        {
            get { return context.CT_CATEGORY; }
        }

        public IQueryable<CT_BRAND> Brands
        {
            get { return context.CT_BRAND; }
        }

        public IQueryable<SK_MODEL> Models
        {
            get { return context.SK_MODEL; }
        }

        public IQueryable<CT_IMAGE> Images
        {
            get { return context.CT_IMAGE; }
        }

        public IQueryable<RS_PRICE> Prices
        {
            get { return context.RS_PRICE; }
        }

        public IQueryable<CT_VAT> Vats
        {
            get { return context.CT_VAT; }
        }

        public IEnumerable<Product> Products
        {
            get
            {
                DateTime curDate = DateTime.Today;
                var products = (from pr in context.RS_PRODUCT
                                join eq in context.SK_EQUIPMENT on pr.EquipmentId equals eq.EquipmentId
                                join ct in context.CT_CATEGORY on eq.CategoryId equals ct.CategoryId                               
                                join md in context.SK_MODEL on pr.ModelId equals md.ModelId
                                join br in context.CT_BRAND on md.BrandId equals br.BrandId

                                join im1 in context.CT_IMAGE on pr.ImageId equals im1.ImageId into im2
                                from im in im2.DefaultIfEmpty()

                                join prc1 in (from price in context.RS_PRICE
                                              where price.DateBegin <= curDate && curDate <= price.DateEnd
                                              select price) on pr.ProductId equals prc1.ProductId into prc2
                                from prc in prc2.DefaultIfEmpty()

                                join v1 in (from vat in context.CT_VAT
                                            where !vat.Rem
                                            select vat) on prc.VatId equals v1.VatId into v2
                                from v in v2.DefaultIfEmpty()
                                orderby pr.ProductId
                                select new Product
                                {
                                    ProductId = pr.ProductId,
                                    EquipmentId = pr.EquipmentId,
                                    CategoryId = eq.CategoryId,                                    
                                    ModelId = pr.ModelId,
                                    BrandId = md.BrandId,
                                    ImageId = pr.ImageId,
                                    Name = pr.Name,
                                    Descr = pr.Descr,
                                    Mass = pr.Mass,
                                    Length = pr.Length,
                                    Width = pr.Width,
                                    Height = pr.Height,
                                    Color = pr.Color,
                                    Power = pr.Power,
                                    Kit = pr.Kit,
                                    EquipmentName = eq.Name,
                                    EquipmentNameExtra = eq.NameExtra,
                                    EquipmentOrd = eq.Ord,
                                    CategoryName = ct.Name,
                                    CategoryOrd = ct.Ord,
                                    BrandName = br.Name,
                                    ModelName = md.Name,
                                    Data = im.Data,
                                    MimeType = im.MimeType,
                                    ImageName = im.Name,
                                    PriceId = prc.PriceId,
                                    PriceWithVat = prc.PriceWithVat,
                                    PriceWithoutVat = prc.PriceWithoutVat,
                                    DateBegin = prc.DateBegin,
                                    DateEnd = prc.DateEnd,
                                    VatName = v.Name,
                                    VatRem = v.Rem
                                }).ToList();

                return products;
            }
        }

        #region Category - Категории
        public void SaveCategory(CT_CATEGORY category)
        {
            category.DateLoad = DateTime.Now;
            if (category.CategoryId == 0)
            {
                context.CT_CATEGORY.Add(category);
            }
            else
            {
                CT_CATEGORY dbEntry = context.CT_CATEGORY.Where(x => x.CategoryId == category.CategoryId).Single(); //.Find(loadRule.LoadRuleId);
                if (dbEntry != null)
                {
                    dbEntry.Code = category.Code;
                    dbEntry.Name = category.Name;
                    dbEntry.Ord = category.Ord;
                    dbEntry.DateLoad = category.DateLoad;
                }
            }
            context.SaveChanges();
        }

        public CT_CATEGORY DeleteCategory(long categoryId)
        {
            CT_CATEGORY dbEntry = context.CT_CATEGORY.Where(x => x.CategoryId == categoryId).Single(); //.Find(LoadRuleId);
            if (dbEntry != null)
            {
                context.CT_CATEGORY.Remove(dbEntry);
                context.SaveChanges();
            }
            return dbEntry;
        }
        #endregion

        #region Vat - НДС
        public void SaveVat(CT_VAT vat)
        {
            vat.DateLoad = DateTime.Now;
            if (vat.VatId == 0)
            {
                context.CT_VAT.Add(vat);
            }
            else
            {
                CT_VAT dbEntry = context.CT_VAT.Where(x => x.VatId == vat.VatId).Single();
                if (dbEntry != null)
                {
                    dbEntry.Code = vat.Code;
                    dbEntry.Name = vat.Name;
                    dbEntry.Rem = vat.Rem;
                    dbEntry.DateLoad = vat.DateLoad;
                }
            }
            context.SaveChanges();
        }

        public CT_VAT DeleteVat(long vatId)
        {
            CT_VAT dbEntry = context.CT_VAT.Where(x => x.VatId == vatId).Single();
            if (dbEntry != null)
            {
                context.CT_VAT.Remove(dbEntry);
                context.SaveChanges();
            }
            return dbEntry;
        }
        #endregion

        #region Equipment - Тип оборудования
        public void SaveEquipment(SK_EQUIPMENT equipment)
        {
            if (equipment.EquipmentId == 0)
            {
                context.SK_EQUIPMENT.Add(equipment);
            }
            else
            {
                SK_EQUIPMENT dbEntry = context.SK_EQUIPMENT.Where(x => x.EquipmentId == equipment.EquipmentId).Single();
                if (dbEntry != null)
                {
                    dbEntry.CategoryId = equipment.CategoryId;
                    dbEntry.Code = equipment.Code;
                    dbEntry.Name = equipment.Name;
                    dbEntry.NameExtra = equipment.NameExtra;
                    dbEntry.Ord = equipment.Ord;
                    dbEntry.IsActive = equipment.IsActive;
                    dbEntry.CT_CATEGORY = equipment.CT_CATEGORY;
                }
            }
            context.SaveChanges();
        }

        public SK_EQUIPMENT DeleteEquipment(long equipmentId)
        {
            SK_EQUIPMENT dbEntry = context.SK_EQUIPMENT.Where(x => x.EquipmentId == equipmentId).Single();
            if (dbEntry != null)
            {
                context.SK_EQUIPMENT.Remove(dbEntry);
                context.SaveChanges();
            }
            return dbEntry;
        }

        public void RefreshEquipmentIsActive()
        {
            var conn = new SqlConnection();
            var connStr = System.Configuration.ConfigurationManager.ConnectionStrings["EFDbContext"].ConnectionString;
            conn.ConnectionString = connStr;

            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.Connection = conn;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "dbo.SP_RFR_EQUIPMENT_ISACTIVE";

                if (conn.State != ConnectionState.Closed)
                    conn.Close();
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }                       
        }
        #endregion

        #region Product - Товар
        public void SaveProduct(RS_PRODUCT product)
        {
            //image
            long? imgId = null;
            CT_IMAGE img = null;
            DateTime dateLoad = DateTime.Now;

            if (product.ProductId != 0 
                && product.ImageId != null)
            {
                img = context.CT_IMAGE.Where(x => x.ImageId == product.ImageId).Single();
                if (img != null)
                {
                    img.Data = product.CT_IMAGE.Data;
                    img.MimeType = product.CT_IMAGE.MimeType;
                    img.Name = product.CT_IMAGE.Name;
                    img.DateLoad = dateLoad;
                }
            }
            else
            {
                if (product.CT_IMAGE.Data != null)
                {
                    img = new CT_IMAGE();
                    img.Data = product.CT_IMAGE.Data;
                    img.MimeType = product.CT_IMAGE.MimeType;
                    img.Name = product.CT_IMAGE.Name;
                    img.DateLoad = dateLoad;
                    context.CT_IMAGE.Add(img);
                }
            }
            context.SaveChanges();
            if (img != null)
                imgId = img.ImageId;

            //product
            product.ImageId = imgId;
            product.CT_IMAGE = img;

            if (product.ProductId == 0)
            {
                context.RS_PRODUCT.Add(product);
            }
            else
            {
                RS_PRODUCT dbEntry = context.RS_PRODUCT.Where(x => x.ProductId == product.ProductId).Single();
                if (dbEntry != null)
                {
                    dbEntry.EquipmentId = product.EquipmentId;
                    dbEntry.ModelId = product.ModelId;
                    dbEntry.ImageId = product.ImageId;

                    dbEntry.Name = product.Name;
                    dbEntry.Descr = product.Descr;
                    dbEntry.Mass = product.Mass;
                    dbEntry.Length = product.Length;
                    dbEntry.Width = product.Width;
                    dbEntry.Height = product.Height;
                    dbEntry.Color = product.Color;
                    dbEntry.Power = product.Power;
                    dbEntry.Kit = product.Kit;

                    dbEntry.SK_EQUIPMENT = product.SK_EQUIPMENT;
                    dbEntry.SK_MODEL = product.SK_MODEL;
                    dbEntry.CT_IMAGE = product.CT_IMAGE;
                }
            }
            context.SaveChanges();
        }

        public RS_PRODUCT DeleteProduct(long productId)
        {
            RS_PRODUCT dbEntry = context.RS_PRODUCT.Where(x => x.ProductId == productId).Single();
            if (dbEntry != null)
            {
                context.RS_PRODUCT.Remove(dbEntry);
                context.SaveChanges();
            }
            return dbEntry;
        }
        #endregion

        #region Brand - Бренд
        public void SaveBrand(CT_BRAND brand)
        {
            if (brand.BrandId == 0)
            {
                context.CT_BRAND.Add(brand);
            }
            else
            {
                CT_BRAND dbEntry = context.CT_BRAND.Where(x => x.BrandId == brand.BrandId).Single();
                if (dbEntry != null)
                {
                    dbEntry.Code = brand.Code;
                    dbEntry.Name = brand.Name;
                }
            }
            context.SaveChanges();
        }

        public CT_BRAND DeleteBrand(long brandId)
        {
            CT_BRAND dbEntry = context.CT_BRAND.Where(x => x.BrandId == brandId).Single();
            if (dbEntry != null)
            {
                context.CT_BRAND.Remove(dbEntry);
                context.SaveChanges();
            }
            return dbEntry;
        }
        #endregion

        #region Model - Модель
        public void SaveModel(SK_MODEL mdl)
        {
            if (mdl.ModelId == 0)
            {
                context.SK_MODEL.Add(mdl);
            }
            else
            {
                SK_MODEL dbEntry = context.SK_MODEL.Where(x => x.ModelId == mdl.ModelId).Single();
                if (dbEntry != null)
                {
                    dbEntry.BrandId = mdl.BrandId;
                    dbEntry.Code = mdl.Code;
                    dbEntry.Name = mdl.Name;
                    dbEntry.CT_BRAND = mdl.CT_BRAND;
                }
            }
            context.SaveChanges();
        }

        public SK_MODEL DeleteModel(long modelId)
        {
            SK_MODEL dbEntry = context.SK_MODEL.Where(x => x.ModelId == modelId).Single();
            if (dbEntry != null)
            {
                context.SK_MODEL.Remove(dbEntry);
                context.SaveChanges();
            }
            return dbEntry;
        }
        #endregion
    }
}
