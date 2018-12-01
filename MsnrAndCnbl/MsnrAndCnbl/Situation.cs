﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MsnrAndCnbl
{
    /// <summary>
    /// Берег реки
    /// </summary>
    enum RiverBank
    {
        Left = 0,
        Right = 1
    }

    /// <summary>
    /// Класс ситуаций. Ситуации относительно одного берега реки (левого).
    /// </summary>
    class Situation
    {
        public const int MSNRALL = 3;
        public const int CNBLALL = 3;

        // Зная ситуацию на одном из берегов реки, нетрудно определить ситуацию на противоположном.
        public Situation() { }

        public Situation(int msn, int cnb, RiverBank rb) : this(msn, cnb, rb, false, 1) { }

        public Situation(int msn, int cnb, RiverBank rb, int depth) : this(msn, cnb, rb, false, depth) { }

        public Situation(int msn, int cnb, RiverBank rb, bool isDLck, int dpth)
        {
            Msnr = msn;
            Cnbl = cnb;
            RvrBnk = rb;
            msnrOpposite = MSNRALL - msn;   // Количество миссионеров на противоположном берегу.
            cnblOpposite = CNBLALL - cnb;   // Количество каннибалов на противоположном берегу.
            IsDeadLock = isDLck;            // Признак тупика - по умолчанию = false, повторная ситуация  - тупиковая  = true.
            Depth = dpth;                   // Глубина залегания вершины.
        }

        private int msnrOpposite;
        private int cnblOpposite;
        //protected Action casualAction = new Action();

        private int msnr;
        /// <summary>
        /// Количество миссионеров.
        /// </summary>
        public int Msnr
        {
            get { return msnr; }
            set { msnr = value; }
        }

        private int cnbl;
        /// <summary>
        /// Количество каннибалов.
        /// </summary>
        public int Cnbl
        {
            get { return cnbl; }
            set { cnbl = value; }
        }

        private RiverBank rvrBnk;
        /// <summary>
        /// Признак лодки на левом берегу: Left 0 - левый берег, Right 1 - правый.
        /// </summary>
        public RiverBank RvrBnk
        {
            get { return rvrBnk; }
            set { rvrBnk = value; }
        }

        private bool isDeadLock;
        /// <summary>
        /// Признак тупика: true - ситуация тупиковая, false - нет.
        /// </summary>
        public bool IsDeadLock
        {
            get
            {
                //!(хорошо)
                return !((msnr >= cnbl || msnr == 0) &&
                         (msnrOpposite >= cnblOpposite || msnrOpposite == 0) &&
                         !isDeadLock);
            }
            set
            {
                isDeadLock = value;
            }
        }

        /// <summary>
        /// Признак конечного состояния.
        /// </summary>
        public bool isEnd
        {
            get
            {
                return (msnr == 0 && cnbl == 0 && (rvrBnk == RiverBank.Right));
            }
        }

        /// <summary>
        /// Глубина залегания вершины.
        /// </summary>
        public int Depth
        { get; private set; }


        /// <summary>
        /// Отображение
        /// </summary>
        public void DisplayStats()
        {
            Console.WriteLine("Situation ({0}, {1}, {2}, {3}, {4}, {5})", Msnr, Cnbl, RvrBnk, IsDeadLock, isEnd, Depth);
        }

        public static Situation operator *(Situation situation, Action action)
        {
            //RiverBank riverBank;        
            //riverBank = (situation.RvrBnk == RiverBank.Left) ? RiverBank.Right : RiverBank.Left;

            if (action.toRvrBnk == toRiverBank.toLeft)
            {
                // Движение к левому берегу, люди прибавляются с правого берега.
                return new Situation(situation.Msnr + action.Msnr, situation.Cnbl + action.Cnbl, RiverBank.Left, situation.Depth + 1);
            }
            else
            {
                // Движение к правому берегу, люди убавляются с левого берега.
                return new Situation(situation.Msnr - action.Msnr, situation.Cnbl - action.Cnbl, RiverBank.Right, situation.Depth + 1);
            }
        }
    }
}
