﻿using System;
using System.Collections.Generic;
using System.Linq;
using ToolsStore.Domain.Entities;

namespace ToolsStore.Domain.Abstract
{
    public interface IRuleRepository
    {
        IQueryable<MT_LOAD_RULE> LoadRules { get; }
    }
}
