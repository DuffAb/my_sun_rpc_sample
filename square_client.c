/*
 * This is sample code generated by rpcgen.
 * These are only templates and you can use them
 * as a guideline for developing your own functions.
 */

#include "square.h"
int
main(int argc, char **argv)
{
	CLIENT		*cl;// 声明客户句柄
	square_in	in;
	square_out	*outp;

	if (argc != 3){
		printf("usage: client <hostname> <integer-value>");
		exit(1);
	}
	printf("0\n");
	// 获取客户句柄  clnt_create() 為客戶端最主要的功能呼叫，主要功能是產生一個 Client/Server 的通訊連線
	cl = clnt_create(argv[1], // 服务器的主机名或IP地址
		SQUARE_PROG, // 程序名(来自square.x文件)
		SQUARE_VERS, // 版本号(来自square.x文件)
		"tcp");
	if (!cl)
	{
		printf("clnt_create failed.\n");
	}
	printf("1\n");
	in.arg1 = atol(argv[2]);
	// 调用远程过程并输出结果
	printf("2 in.arg1(%d)\n", in.arg1);
	if ( (outp = squareproc_1(&in, cl)) == NULL){
		printf("%s", clnt_sperror(cl, argv[1]));
		exit(1);
	}
	
	printf("result: %ld\n", outp->res1);
	exit(0);
}