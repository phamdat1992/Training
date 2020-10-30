// Radix Sort.
// Input a number ( n ) and make an real array having n elements ( random ). 
// Sort them in the order increase.
// references:
//   1. key-indexed counting: www.cs.princeton.edu/courses/.../51DemoKeyIndexedCounting.pdf
//   2. counting sort: http://www.code2learn.com/2012/01/counting-sort-algorithm-with-example.html
//   3. counting sort anh radix sort: http://opendatastructures.org/ods-java/11_2_Counting_Sort_Radix_So.html
// ---------------------------------------------------

#include <time.h>
#include <iostream>

// ---------------------------------------------------

using namespace std;

// ---------------------------------------------------
// Basic types

typedef long int32;
typedef unsigned long uint32;
typedef float real32;
typedef double real64;

// Configuration--------------------------------------

// ===================================================

const uint32 kHist = 2048; 

// ===================================================
// Prototypes

inline uint32 Flip( uint32 x);
inline uint32 IFlip( uint32 x );
//inline uint32 FlipSign( uint32 x );

//void Random_Arr_int32( int32 *a, uint32 elements );
void Random_Arr_real32( real32 *a, uint32 elements );

void RadixSort( uint32 *source, uint32 *dest, uint32 elements );

// ===================================================

   #define _0( x ) ( x & 0x7FF )
   #define _1( x ) ( x >> 11 & 0x7FF )
   #define _2( x ) ( x >> 22 )


   inline uint32 Flip( uint32 x) {

	   return x ^ ( -int32( x >> 31 ) | 0x80000000 );
   }

   inline uint32 IFlip( uint32 x ) {

	   return x ^ ( ( ( x >> 31) - 1 ) | 0x80000000 );
   }

// ===================================================
// Flip sign bit.

//inline uint32 FlipSign( uint32 x ) {

//	return x ^ 0x80000000;
//}

// ===================================================
// Radix Sort Use Counting Sort

void RadixSort( uint32 *source, uint32 *dest, uint32 elements ) {

	uint32 b0[ kHist*3 ] = { 0 };
	uint32 *b1 = b0 + kHist;
	uint32 *b2 = b1 + kHist;
	uint32 fi;

	// making histograms
	for( uint32 i = 0; i < elements; ++i ) {
	
		fi = Flip( source[ i ] );

		++b0[ _0( fi ) ];
		++b1[ _1( fi ) ];
		++b2[ _2( fi ) ];
	}

	{
		uint32 sum0 = 0, sum1 = 0, sum2 = 0;
		uint32 tsum;

		for( uint32 i = 0; i < kHist; ++i ) {

			tsum = b0[ i ] + sum0;
			b0[ i ] = sum0 - 1;
			sum0 = tsum;

			tsum = b1[ i ] + sum1;
			b1[ i ] = sum1 - 1;
			sum1 = tsum;

			tsum = b2[ i ] + sum2;
			b2[ i ] = sum2 - 1;
			sum2 = tsum;
		}
	}
	
	// sort for bits 0 - 10
	for( uint32 i = 0; i < elements; ++i ) {

		fi = Flip( source[ i ] );
		dest[ ++b0[ _0( fi ) ] ] = fi;
	}

	// sort for bits 11 - 21
	for( uint32 i = 0; i < elements; ++i ) {

		source[ ++b1[ _1( dest[ i ] ) ] ] = dest[ i ];
	}

	// sort for bits 22 - 31
	for( uint32 i = 0; i < elements; ++i ) {

		dest[ ++b2[ _2( source[ i ] ) ] ] = IFlip( source[ i ] );
	}
}

// ===================================================
// Make random data for array.

//void Random_Arr_int32( int32 *a, uint32 elements ) {

//	srand( ( unsigned int )( time( 0 ) ) );

//	for( int i = 0; i < elements; ++i ) {

//		a[ i ] = rand(  );
//		if( rand(  ) & 1 ) { a[ i ] = -a[ i ]; }
//	}
//}

void Random_Arr_real32( real32 *a, uint32 elements ) {

	srand( ( unsigned int )( time( 0 ) ) );

	for( int i = 0; i < elements; ++i ) {

		a[ i ] = ( real32 )rand(  )/18792;
		if( rand(  ) & 1 ) { a[ i ] = -a[ i ]; }
	}
}

// ===================================================
// Main source.

void main( void ) {

	clock_t start, finish;
	uint32 elements;

	// Input array's length.
	cout<<"n: ";
	cin>>elements;

	// Sort integer array.
//	{
//		int32 *source = new int32[ elements ];
//		int32 *dest = new int32[ elements ];

//		Random_Arr_int32( source, elements );
		
//		start = clock(  );
//		RadixSort( ( uint32* )source, ( uint32* )dest, elements );
//		finish = clock(  );

//		cout<<"integer array: "<<real64( finish - start )/CLOCKS_PER_SEC<<endl;

//		delete []source;
//		delete []dest;
//	}

	//Sort real array.
	{
		real32 *source = new real32[ elements ];
		real32 *dest = new real32[ elements ];

		Random_Arr_real32( source, elements );

		start = clock(  );
		RadixSort( ( uint32* ) source, ( uint32* )dest, elements );
		finish = clock(  );

		cout<<"real array: "<<real64( finish - start )/CLOCKS_PER_SEC<<endl;

		delete [ ]source;
		delete [ ]dest;
	}
	
	system( "pause" );
}