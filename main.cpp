#include <iostream>
#include <cstdio>
#include <fstream>
#include <iomanip>
#include "dependences/include/libpq-fe.h"

#define PG_HOST     "127.0.0.1"
#define PG_USER     "postgres"
#define PG_DB       "leddit"
#define PG_PASS     ""
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

    res = PQexec (conn , " select username as \"Proprietario\", f.nome as \"Nome feed\", i.sub as \"Sub incluso\"\n"
                         "from utente u join feed f on u.username=f.utente join include i on (f.nome=i.feed and f.utente=i.utente)\n"
                         "group by username, f.nome, i.sub\n"
                         "order by username, f.nome; ");

    checkResults(res,conn);

    int tuple = PQntuples (res );
    int campi = PQnfields (res );

    // Stampo intestazioni
    for ( int i = 0; i < campi ; ++i){
        cout << PQfname(res,i) << std::setw(20);
    }
    cout << "\n" << std::setfill('-') << std::setw(60) << "-" << "\n" << std::setfill(' ');
    //stampo i valori selezionati
    for ( int i = 0; i < tuple ; ++i){
        for ( int j = 0; j < campi ; ++j){
            cout << std::setw(20) << std::left << PQgetvalue (res , i, j);
        }
        cout << endl;
    }

    PQclear(res);

    /*cout << " Esempio 2" << endl ;

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
*/
    cout << " Complete " << endl ;
    PQfinish(conn);
    return 0;




    //TODO: Codice da testare
    /*int main()
    {
        MYSQL *conn;
        MYSQL_RES *res;
        MYSQL_ROW row;
        char *server = "server";
        char *user = "username";
        char *password = "password";
        char *database = "local";
        conn = mysql_init(NULL);
        mysql_real_connect(conn, server, user, password, database, 0, NULL, 0);
        mysql_query(conn, "SELECT * FROM website");
        res = mysql_use_result(conn);
        printf("id \t date\t time \t comments\t\t user\n");
        while ((row = mysql_fetch_row(res)) != NULL)
        {
            printf("%s \t %s\t %s\t %s\t\t %s\n", row[0], row[1], row[2], row[3], row[4]);
        }
        mysql_free_result(res);
        mysql_close(conn);

        return 0;
    }*/

}