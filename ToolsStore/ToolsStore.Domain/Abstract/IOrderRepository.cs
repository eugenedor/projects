﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Linq;
using ToolsStore.Domain.Entities;

namespace ToolsStore.Domain.Abstract
{
    public interface IOrderRepository
    {
        IQueryable<RS_ORDER> Orders { get; }

        IQueryable<RS_CART> Crts { get; }

        IEnumerable<CartX> Carts { get; }
    }
}