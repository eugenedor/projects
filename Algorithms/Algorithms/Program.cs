﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Threading;

namespace Algorithms
{
    internal class Program
    {
        private static void Main(string[] args)
        {
            var items = 8;
            Sort(items);
            Search(items);
            Console.ReadKey();
        }

        public static void Sort(int cntItem)
        {
            var arr0 = SetArr(cntItem);
            Print.PrintArr(arr0, "BubbleSort");
            AlgorithmsSort.BubbleSort(arr0);
            Print.PrintArr(arr0);            

            var arr1 = SetArr(cntItem);
            Print.PrintArr(arr1, "SelectionSort");
            AlgorithmsSort.SelectionSort(arr1);
            Print.PrintArr(arr1); 

            var arr2 = SetArr(cntItem);
            Print.PrintArr(arr2, "InsertionSort");
            AlgorithmsSort.InsertionSort(arr2);
            Print.PrintArr(arr2);        

            var arr3 = SetArr(cntItem);
            Print.PrintArr(arr3, "MergeSort");
            AlgorithmsSort.MergeSort(arr3, 0, cntItem-1);
            Print.PrintArr(arr3);
        }

        public static void Search(int cntItem)
        {
            var arr4 = new int[] { 1, 2, 3, 5, 7, 12, 25, 37};
            int val = 7, inxL = 3, inxR = 6;
            Print.PrintArr(arr4, "LinearSearch");
            Print.PrintShort(arr4, inxL, inxR);
            var inx = AlgorithmsSearch.LinearSearch(val, arr4, inxL, inxR);
            Console.WriteLine("After:");
            Console.WriteLine($"Value = {val}; indexLeft = {inxL}; indexRight = {inxR}; indexSearch = {inx}");

            //var arr5 = new int[] { 1, 2, 3, 4, 5, 6, 7, 8, 9 };
        }

        /// <summary>
        /// Рандомный массив из n элементов
        /// </summary>
        public static int[] SetArr(int n)
        {
            var arr = new int[n];
            var ran = new Random();
            for (var i = 0; i < arr.Length; i++)
            {
                arr[i] = ran.Next(0, 99);
            }

            Thread.Sleep(100);
            return arr;
        }
    }
}
