CC = gcc
CFLAGS = -g -DRPC_SVC_FG
RPCGEN_FLAG = -C

all: square_client square_server

# the executables: square_client and square_server

square_client: square_client.o square_clnt.o square_xdr.o
	$(CC) -o square_client square_client.o square_clnt.o square_xdr.o -lnsl

square_server: square_server.o square_svc.o  square_xdr.o
	$(CC) -o square_server square_server.o square_svc.o square_xdr.o -lnsl

# object files for the executables 

square_server.o: square_server.c square.h
	$(CC) $(CFLAGS) -c square_server.c

square_client.o: square_client.c square.h
	$(CC) $(CFLAGS) -c square_client.c

# compile files generated by rpcgen

square_svc.o: square_svc.c square.h
	$(CC) $(CFLAGS) -c square_svc.c

square_clnt.o: square_clnt.c square.h
	$(CC) $(CFLAGS) -c square_clnt.c

square_xdr.o: square_xdr.c square.h
	$(CC) $(CFLAGS) -c square_xdr.c

# square.x produces square.h, square_clnt.c, square_svc.c, and square_xdr.c
# make sure we regenerate them if our interface (square.x) changes

square.h square_clnt.c square_svc.c square_xdr.c:	square.x
	rpcgen $(RPCGEN_FLAG) square.x

clean:
	rm -f square_client square_client.o square_server square_server.o square_clnt.* square_svc.* square_xdr.* square.h
