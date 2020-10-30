#include <cstdio>

#define MAXNUM 1000000000000000000ll

void input( int &n ) {

	scanf( "%d", &n );
}

void output( long long kq ) {

	printf( "%lld", kq );
}

long long MIN( long long a, long long b ) {

	return ( a < b )? a : b;
}

void solved( int n, int f, long long &kq, long long m, long long* a ) {

	if( n == 1 ) {  kq = MIN( kq, m ); }
	else {

		for( int i = 2; i <= 59; ++i ) {

			if( n%i == 0 ) {

				long long g = m;
				for( int j = 1; j <= i - 1 && MAXNUM/g >= a[f]; ++j ) {

					g *= a[f];
				}
				
				solved( n/i, f+1, kq, g, a );
			}
		}
	}
}

int main(  ) {

	long long a [1000] = {2l, 3l, 5l, 7, 11l, 13l, 17l, 19l, 23l, 29l, 
			31l, 37l, 41l, 43l, 47l, 53l, 59l, 61l, 67l, 71l, 
			73l, 79l, 83l, 89l, 97l, 101l, 103l, 107l, 109l, 113l, 
			127l, 131l, 137l, 139l, 149l, 151l, 157l, 163l, 167l, 173l, 
			179l, 181l, 191l, 193l, 197l, 199l, 211l, 223l, 227l, 229l, 
			233l, 239l, 241l, 251l, 257l, 263l, 269l, 271l, 277l, 281l, 
			283l, 293l, 307l, 311l, 313l, 317l, 331l, 337l, 347l, 349l, 
			353l, 359l, 367l, 373l, 379l, 383l, 389l, 397l, 401l, 409l, 
			419l, 421l, 431l, 433l, 439l, 443l, 449l, 457l, 461l, 463l, 
			467l, 479l, 487l, 491l, 499l, 503l, 509l, 521l, 523l, 541l, 
			547l, 557l, 563l, 569l, 571l, 577l, 587l, 593l, 599l, 601l, 
			607l, 613l, 617l, 619l, 631l, 641l, 643l, 647l, 653l, 659l, 
			661l, 673l, 677l, 683l, 691l, 701l, 709l, 719l, 727l, 733l, 
			739l, 743l, 751l, 757l, 761l, 769l, 773l, 787l, 797l, 809l, 
			811l, 821l, 823l, 827l, 829l, 839l, 853l, 857l, 859l, 863l, 
			877l, 881l, 883l, 887l, 907l, 911l, 919l, 929l, 937l, 941l};


	long long kq = MAXNUM;
	int n;

	input( n );
	solved( n, 0, kq, 1, a );
	output( kq );
}