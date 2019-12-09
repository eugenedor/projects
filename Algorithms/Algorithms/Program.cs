﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Threading;

namespace Algorithms
{
    class Program
    {
        static void Main(string[] args)
        {
            var cntItem = 10;

            //BubbleSort
            var arr0 = SetArr(cntItem);
            Console.WriteLine("Сортировка пузырьком:");
            Console.WriteLine("До:");
            PrintArr(arr0);
            Algorithm.BubbleSort(arr0);
            Console.WriteLine("После:");
            PrintArr(arr0);
            Console.WriteLine();

            //SelectionSort
            var arr1 = SetArr(cntItem);
            Console.WriteLine("Сортировка выборкой:");
            Console.WriteLine("До:");
            PrintArr(arr1);
            Algorithm.SelectionSort(arr1);
            Console.WriteLine("После:");
            PrintArr(arr1);
            Console.WriteLine();

            Console.ReadKey();
        }

        public static int[] SetArr(int c)
        {
            var arr = new int[c];
            Random ran = new Random();
            for (int i = 0; i < arr.Length; i++)
            {
                arr[i] = ran.Next(1, 99);
            }

            Thread.Sleep(100);
            return arr;
        }

        public static void PrintArr(int[] arr)
        {
            for (int i = 0; i < arr.Length; i++)
            {
                Console.Write("{0} ", arr[i]);
            }
            Console.WriteLine();
        }
    }
}
