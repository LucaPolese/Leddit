#include <iostream>
#include <cstdio>
#include <fstream>
#include "dependences/include/libpq-fe.h"

#define PG_HOST     "127.0.0.1"
#define PG_USER     "postgres"
#define PG_DB       "reddit"
#define PG_PASS     "PASSWORD"
#define PG_PORT     5432

using namespace std;

void checkResults ( PGresult * res , const PGconn * conn ) {
    if (PQresultStatus(res) != PGRES_TUPLES_OK) {
        cout << " Risultati inconsistenti " << PQerrorMessage(conn);
        PQclear(res);
        exit(1);
    }
}

int main(int argc, char*argv[]) {
    cout << " Start " << endl ;
    char conninfo[250];
    sprintf(conninfo, "user=%s password=%s dbname=%s hostaddr=%s port=%d", PG_USER,PG_PASS,PG_DB,PG_HOST,PG_PORT);
    PGconn* conn;
    conn = PQconnectdb(conninfo);

    if ( PQstatus(conn) != CONNECTION_OK ) {
        cout << " Errore di connessione \n" << PQerrorMessage(conn);
        PQfinish(conn);
        exit(1);
    }

    cout << " Connessione avvenuta correttamente " << endl ;

    cout << " Esempio 1" << endl ;
    PGresult * res;

    res = PQexec (conn , " SELECT * FROM hubs ");

    checkResults(res,conn);

    int tuple = PQntuples (res );
    int campi = PQnfields (res );

    // Stampo intestazioni
    for ( int i = 0; i < campi ; ++i){
        cout << PQfname (res ,i) << "\t\t";
    }
    cout << endl;

    //stampo i valori selezionati
    for ( int i = 0; i < tuple ; ++i){
        for ( int j = 0; j < campi ; ++j){
            cout << PQgetvalue (res , i, j) << "\t\t";
        }
        cout << endl ;
    }

    PQclear(res);

    cout << " Esempio 2" << endl ;

    string query = " SELECT origin , destination , departure_time , arrival_time FROM hubs JOIN legs on origin = hub WHERE country = $1 ::varchar ";

    PGresult * stmt = PQprepare (conn ," query_legs ", query.c_str() , 1, NULL );
    string country ;

    cout << " Inserire codice paese di origine : ";
    cin >> country ;
    const char* parameter = country.c_str();

    res = PQexecPrepared (conn , " query_legs ", 1, & parameter , NULL , 0, 0);
    checkResults (res , conn );

    ofstream myfile (" example.csv ");

    tuple = PQntuples (res);
    campi = PQnfields (res);
    for ( int i= 0; i < campi ; ++i){
        myfile << PQfname (res ,i) << ",";
        }
    myfile << endl ;

    for ( int i = 0; i < tuple ; ++i){
        for ( int j = 0; j < campi ; ++j){
            myfile << PQgetvalue (res , i, j) << ",";
        }
        myfile << endl ;
        }
    myfile.close();

    cout << " Complete " << endl ;
    PQfinish(conn);
    return 0;
}
