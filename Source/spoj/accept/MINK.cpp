#include <iostream>
#include <cstdio>
#include <deque>

using namespace std;

int a [100000];
int n, k, g;

deque< int > s;

void push( int x ) {

	for( ; !s.empty() && a[s.back()] >= a[x]; s.pop_back() );

	s.push_back( x );
}

void pop( int x ) {

	for( ; !s.empty() && s.front() <= x; s.pop_front() );
}

void GET_INT( int &x ) {

	register int c;

	for( c = getchar_unlocked(); c < '0' || c > '9'; c = getchar_unlocked() );

	x = c - '0';
	for( c = getchar_unlocked(); c >= '0' && c <= '9'; c = getchar_unlocked() ) {

		x = ( x<<3 ) + ( x<<1 ) + c - '0';
	}
}

void input(  ) {

	GET_INT( n );
	GET_INT( k );

	for( int i = 1; i <= n; ++i ) {

		GET_INT( a[i] );
	}
}

void solved(  ) {

	s.clear();

	for( int i = 1; i <= k; ++i ) { push( i ); }

	printf( "%d ", a[s.front()] );
	for( int i = k + 1; i <= n; ++i ) {

		pop( i-k );
		push( i );
		printf( "%d ", a[s.front()] );
	}

	printf( "\n" );
}

int main(  ) {

	GET_INT( g );

	for( int i = 0; i < g; ++i ) {

		input(  );
		solved(  );
	}
}