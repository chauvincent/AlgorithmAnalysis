import java.util.Random;
import java.util.Vector;
import java.io.IOException;
import java.util.Scanner;
import java.io.*;

class QuickSortVerbose
{
    static int k = 0;
    public static void main(String [] args)
    {
    	Vector<Integer> v = new Vector<>();

        Scanner scanner = null;
        try
        {
            String filename = args[1];
 			scanner = new Scanner(new File(filename));
        } catch (FileNotFoundException e)
        {
        	System.exit(1);	
        }	
        while (scanner.hasNext())
        {
        	if(scanner.hasNextInt())
        	{
        		v.add(scanner.nextInt());
        	}
        	else
        	{
        		scanner.next();
        	}
        }
        int[] a = new int[v.size()];
        int count = 0;

		for (int i = 0; i < v.size(); i++)
		{
			a[i] = ((Integer)v.elementAt(i)).intValue();
		}
      
   	    int low = 0;
        int high = a.length - 1;
        k = Integer.parseInt(args[0]);
        quicksort(a,low,high);

        for(int i = 0; i < a.length; i++)
        {
        	System.out.println(a[i]);
        }
    }
    public static void quicksort(int[] a, int lo, int hi)
    {
        if (hi - lo <= k)
        {
            insertionSort(a);
        }
        else
        {
            if (hi <= lo) return;
            int i = lo-1, j = hi;
            int t; // v = a[hi];
            int v = new Random().nextInt(a[hi] + 1);
            while (true)
            {
                while (a[++i] < v) ;
                while (v < a[--j]) if (j == lo) break;
                if (i >= j) break;
                t = a[i]; a[i] = a[j]; a[j] = t;
            }
            t = a[i]; a[i] = a[hi]; a[hi] = t;

            quicksort(a, lo, i-1);
            quicksort(a, i+1, hi);
        }
    }
    public static void insertionSort(int[] a)
    {
      int i, j, temp;
      for (i = 1; i < a.length; i++)
      {
          for (j = i; j > 0 && a[j-1] > a[j]; j--)
          {
              temp = a[j];
              a[j] = a[j-1];
              a[j-1] = temp;
          }
      }
    }
}