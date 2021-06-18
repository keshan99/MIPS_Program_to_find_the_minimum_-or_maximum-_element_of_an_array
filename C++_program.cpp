#include <iostream>
using namespace std;

int min2(int x1, int x2)
{
    if (x1 < x2)
        return x1;
    else
        return x2;
}

int getMin(int arr[], int n)
{
    int res = arr[0];
    for (int i = 1; i < n; i++)
        res = min2(res, arr[i]);
    return res;
}

int max2(int x1, int x2)
{
    if (x1 > x2)
        return x1;
    else
        return x2;
}

int getMax(int arr[], int n)
{
    int res = arr[0];
    for (int i = 1; i < n; i++)
        res = max2(res, arr[i]);
    return res;
}

int main()
{
    int arr[] = {12, 1234, 45, 67, 1};
    int n = 5;

    cout << "\n\n";

    cout << "Minimum element of array: " << getMin(arr, n) << "\n";
    cout << "Maximum element of array: " << getMax(arr, n);

    cout << "\n\n";

    return 0;
}