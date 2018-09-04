﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using ToolsStore.Domain.Entities;

namespace ToolsStore.WebUI.Models
{
    /// <summary>
    /// Список товаров
    /// </summary>
    public class ProductsListViewModel
    {
        /// <summary>
        /// Товары
        /// </summary>
        public IEnumerable<RS_PRODUCT> Products { get; set; }

        /// <summary>
        /// Пейджинг (нумерация страниц)
        /// </summary>
        public PagingInfo PagingInfo { get; set; }

        /// <summary>
        /// Текущее оборудование
        /// </summary>
        public long CurrentEquipment { get; set; }
    }
}