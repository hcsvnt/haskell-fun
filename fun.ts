// []                                -->  "no one likes this"
// ["Peter"]                         -->  "Peter likes this"
// ["Jacob", "Alex"]                 -->  "Jacob and Alex like this"
// ["Max", "John", "Mark"]           -->  "Max, John and Mark like this"
// ["Alex", "Jacob", "Mark", "Max"]  -->  "Alex, Jacob and 2 others like this"

export const likes = (a: string[]): string => {
    const count = a.length;

    switch (count) {
        case 0:
            return 'no one likes this';
            break;
        case 1:
            return `${a[0]} likes this`;
        case 2:
            return `${a[0]} and ${a[1]} like this`;
        case 3:
            return `${a[0]}, ${a[1]} and ${a[2]} like this`;
        default:
            return `${a[0]}, ${a[1]} and ${count - 2} others like this`;
            break;
    }
};

export function findOutlier(integers: number[]): number {
    const sorted = integers.reduce<{ evens: number[]; odds: number[] }>(
        (accumulator, current) => {
            return current % 2 === 0
                ? {
                      evens: [...accumulator.evens, current],
                      odds: [...accumulator.odds],
                  }
                : {
                      evens: [...accumulator.evens],
                      odds: [...accumulator.odds, current],
                  };
        },
        {
            evens: [],
            odds: [],
        }
    );

    return sorted.evens.length === 1 ? sorted.evens[0] : sorted.odds[0];
}

// wrong
export const towerBuilder = (nFloors: number): string[] => {
    let tower: string[] = [];
    const base = Array(nFloors)
        .map((item) => '*')
        .join();
    tower = [...tower, base];

    if (nFloors >= 1) {
        towerBuilder(nFloors - 1);
    }

    return tower;
};

export function findUniqNumber(arr: number[]): number {
    const sorted = arr.sort((a, b) => a - b);
    return sorted[0] === sorted[1] ? sorted[sorted.length - 1] : sorted[0];
}

// wrong
// ["NORTH", "SOUTH", "SOUTH", "EAST", "WEST", "NORTH", "WEST"]
export function dirReduc(array: string[]): string[] {
    function isOpposite(direction1: string, direction2: string) {
        return (
            (direction1 === 'NORTH' && direction2 === 'SOUTH') ||
            (direction1 === 'SOUTH' && direction2 === 'NORTH') ||
            (direction1 === 'EAST' && direction2 === 'WEST') ||
            (direction1 === 'WEST' && direction2 === 'EAST')
        );
    }

    const result = array.map((item, index, arr) => {
        if (isOpposite(item, arr[index - 1])) {
            arr.splice(index - 1, 2);
        }

        if (isOpposite(item, arr[index + 1])) {
            arr.splice(index, 2);
        }

        return item;
    });

    return result;
}

// not done, wow
// chooseBestSum(163, 3, [50, 55, 56, 57, 58]),
// export function chooseBestSum(distance: number, count: number, list: number[]): number | null {
//     const first = list.slice(0, count);
//     const firstSum = first.reduce((accumulator, current) => accumulator + current, 0);
//     const difference = distance - firstSum;

//     if (difference === 0) {
//         return firstSum;
//     }
// }

// createPhoneNumber([1, 2, 3, 4, 5, 6, 7, 8, 9, 0]) // => returns "(123) 456-7890"
export function createPhoneNumber(numbers: number[]): string {
    const groups = [numbers.slice(0, 3), numbers.slice(3, 6), numbers.slice(6)].map((group) => group.join(''));

    return `(${groups[0]}) ${groups[1]}-${groups[2]}`;
}

// "56 65 74 100 99 68 86 180 90" ordered by numbers weights becomes:

// "100 180 90 56 65 74 68 86 99"

export function orderWeight(string: string): string {
    return string
        .split(' ')
        .map((item) => {
            const sum = item.split('').reduce((accumulator, current) => {
                return Number(accumulator) + Number(current);
            }, 0);

            return {
                sum,
                item,
            };
        })
        .sort((a, b) => {
            if (a.sum === b.sum) {
                return a.item.localeCompare(b.item);
            }

            return a.sum - b.sum;
        })
        .map((item) => item.item)
        .join(' ');
}

export class PaginationHelper {
    private collection: any[];
    private itemsPerPage: number;

    constructor(collection: any[], itemsPerPage: number) {
        this.collection = collection;
        this.itemsPerPage = itemsPerPage;
    }

    itemCount() {
        return this.collection.length;
    }

    pageCount() {
        return Math.ceil(this.collection.length / this.itemsPerPage);
    }

    pageItemCount(pageIndex: number) {
        if (this.itemCount() === 0) {
            return -1;
        }

        if (pageIndex >= this.pageCount() || pageIndex < 0) {
            return -1;
        }

        if (pageIndex === this.pageCount() - 1) {
            return this.itemCount() - (this.pageCount() - 1) * this.itemsPerPage;
        }

        return this.itemsPerPage;
    }

    pageIndex(itemIndex: number) {
        if (this.itemCount() === 0) {
            return -1;
        }

        if (itemIndex >= this.itemCount() || itemIndex < 0) {
            return -1;
        }

        if (this.itemCount() <= this.itemsPerPage) {
            return 0;
        }

        return Math.floor(itemIndex / this.itemsPerPage);
    }
}

// ISBN-10 identifiers are ten digits long. The first nine characters are digits 0-9. The last digit can be 0-9 or X, to indicate a value of 10.
// An ISBN-10 number is valid if the sum of the digits multiplied by their position modulo 11 equals zero.
// For example:
// ISBN     : 1 1 1 2 2 2 3 3 3  9
// position : 1 2 3 4 5 6 7 8 9 10

export function validISBN10(isbn: string): boolean {
    const chars = isbn.split('');

    // if the length isn't correct, return false
    if (chars.length !== 10) {
        return false;
    }

    // if any of 1-9 chars aren't numbers, return false
    if (chars.slice(0, 9).some((char) => isNaN(Number(char)))) {
        return false;
    }

    // convert all string chars to numbers, convert X to 10
    const numbers = chars.map((char, index) => {
        if (index === 9 && char === 'X') {
            return 10;
        }

        return Number(char);
    });

    return numbers.reduce((accumulator, current, index) => accumulator + current * (index + 1), 0) % 11 === 0;
}

// There is an array of strings. All strings contains similar letters except one. Try to find it!

// findUniq([ 'Aa', 'aaa', 'aaaaa', 'BbBb', 'Aaaa', 'AaAaAa', 'a' ]) === 'BbBb'
// findUniq([ 'abc', 'acb', 'bac', 'foo', 'bca', 'cab', 'cba' ]) === 'foo'

export function findUniq(array: string[]): string {
    const letterStats = array
        .join('')
        .split('')
        .map((letter) => letter.toLowerCase())
        .reduce<{ [key: string]: number }>((accumulator, current) => {
            return {
                ...accumulator,
                [current]: accumulator[current] ? accumulator[current] + 1 : 1,
            };
        }, {});

    const leastCommon = Object.entries(letterStats).sort((a, b) => a[1] - b[1])[0][0];
    const secondLeastCommon = Object.entries(letterStats).sort((a, b) => a[1] - b[1])[1][0];

    const tidyArray = array.map((entry) => {
        if (!entry) return;
        return entry
            .split('')
            .map((letter) => letter.toLowerCase())
            .join('');
    });

    const happyOnes = tidyArray.map((entry, index) => {
        if (entry?.includes(leastCommon)) {
            return index;
        }
        return;
    });

    const happyOnes2 = tidyArray.map((entry, index) => {
        if (entry?.includes(secondLeastCommon)) {
            return index;
        }
        return;
    });

    return array[happyOnes[0] || 0] || array[happyOnes2[0] || 0];
}


// "Interesting" Numbers

// Interesting numbers are 3-or-more digit numbers that meet one or more of the following criteria:

// Any digit followed by all zeros: 100, 90000
// Every digit is the same number: 1111
// The digits are sequential, incrementing†: 1234
// The digits are sequential, decrementing‡: 4321
// The digits are a palindrome: 1221 or 73837
// The digits match one of the values in the awesomePhrases array
// † For incrementing sequences, 0 should come after 9, and not before  1, as in 7890.
// ‡ For decrementing sequences, 0 should come after 1, and not before  9, as in
// 3210.
