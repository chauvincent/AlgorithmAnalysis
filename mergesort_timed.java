import java.util.Random;
import java.util.Vector;
import java.io.IOException;
import java.util.Scanner;
import java.io.*;
class MergeSortTimed
{
    static int MAX_VALUE = 2147483647;
    public static void main(String [] args)
    {
    	Vector<Integer> v = new Vector<>();

        Scanner scanner = null;
        try
        {
            String filename = args[0];
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
        mergesort(a,low,high);
    }
    public static void mergesort(int[] a, int lo, int hi)
    {
        if (hi <= lo) 
            return;

        int mid1 = lo + ((hi - lo) / 3);
        int mid2 = lo + (2*((hi - lo) /3));

        mergesort(a, lo, mid1);
        mergesort(a, mid1+1,mid2);
        mergesort(a, mid2+1, hi);
      
        int[] b = new int[mid1-lo + 2];
        int[] c = new int[mid2 - mid1 + 2];
        int[] d = new int[hi - mid2 + 2];

        for (int k = lo; k <= mid1; k++)
            b[k-lo] = a[k];

        for (int k = mid1+1; k<= mid2; k++)
            c[k-(mid1+1)] = a[k];

        for (int k = mid2+1; k<=hi; k++)
            d[k-(mid2+1)] = a[k];
        
        b[mid1-lo+1] = MAX_VALUE;
        c[mid2-mid1+1] = MAX_VALUE;
        d[hi-mid2+1] = MAX_VALUE;

        int q = 0, w = 0, e = 0; 
        for(int i = lo; i <= hi; i++)
        {
            if(q <= b.length-2 && w <= c.length-3 && e <= d.length-3)
            {
                if(b[q] <= c[w] && b[q] <= d[e]){
                    a[i] = b[q++];
                }
                else if (b[q] >= c[w] && d[e] >= c[w])
                {
                    a[i] = c[w++];
                }
                else if (b[q] >= d[e] && d[e] <= c[w])
                {
                    a[i] = d[e++];
                }
            }
            else if(q <= b.length-2 && w <= c.length-3 && !(e <= d.length-3))
            {
                if(b[q] <= c[w]){
                    a[i] = b[q++];
                }
                else if (b[q] >= c[w])
                {
                    a[i] = c[w++];
                }
            }
            else if(q <= b.length-2 && !(w <= c.length-3) && e <= d.length-3)
            {
                if(b[q] <= d[e]){
                    a[i] = b[q++];
                }
                else if (b[q] >= d[e])
                {
                    a[i] = d[e++];
                }
            }
            else if(!(q <= b.length-2) && w <= c.length-3 && e <= d.length-3)
            {
                if (d[e] >= c[w])
                {
                    a[i] = c[w++];
                }
                else if (d[e] <= c[w])
                {
                    a[i] = d[e++];
                }
            }
            else if(!(q <= b.length-2 && w <= c.length-3) && e <= d.length-3)
            {
                a[i] = d[e++];
            }
            else if( !(q <= b.length-2) && w <= c.length-3 && !(e <= d.length-3))
            {
                    a[i] = c[w++];
            }
            else if(q <= b.length-2 && !(w <= c.length-3 && e <= d.length-3))
            {
                    a[i] = b[q++];
            }
        }
    }
}