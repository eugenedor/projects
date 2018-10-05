﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ToolsStore.Domain.Abstract;
using ToolsStore.Domain.Entities;


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

                                join ct1 in context.CT_CATEGORY on eq.CategoryId equals ct1.CategoryId into ct2
                                from ct in ct2.DefaultIfEmpty()

                                join br in context.CT_BRAND on pr.BrandId equals br.BrandId
                                join md in context.SK_MODEL on pr.ModelId equals md.ModelId

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
                                    BrandId = pr.BrandId,
                                    ModelId = pr.ModelId,
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
    }
}
