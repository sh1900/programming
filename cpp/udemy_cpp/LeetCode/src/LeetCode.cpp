//============================================================================
// Name        : LeetCode.cpp
// Author      : Ethen
// Version     :
// Copyright   : Your copyright notice
// Description : Hello World in C++, Ansi-style
//============================================================================

#include <iostream>
#include <vector>
using namespace std;

int findKthLargest(vector<int>& nums, int k) {
	sort(nums.begin(), nums.end());
	return nums[k - 1];
}

int partition(vector<int>& nums, int left, int right) {
    int pivot = nums[left];
    int l = left + 1, r = right;
    while (l <= r) {
        if (nums[l] < pivot && nums[r] > pivot)
            swap(nums[l++], nums[r--]);
        if (nums[l] >= pivot) l++;
        if (nums[r] <= pivot) r--;
    }
    swap(nums[left], nums[r]);
    return r;
}

int main() {
	vector<int> nums = {3, 2, 1, 5, 6, 4};
	//cout << findKthLargest(nums, 2) << endl;

	int left = 0, right = nums.size() - 1;
	cout << partition(nums, left, right) << endl;

	vector<int>::iterator it;
	for (it = nums.begin(); it != nums.end(); it++) {
		cout << *it << flush;
	}

	return 0;
}