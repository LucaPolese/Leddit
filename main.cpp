#include <iostream>
#include <cstdio>
#include <iomanip>
#include "dependencies/include/libpq-fe.h"
using namespace std;

void checkResults ( PGresult * res , const PGconn * conn ) {
    if (PQresultStatus(res) != PGRES_TUPLES_OK) {
        cout << " Risultati inconsistenti " << PQerrorMessage(conn);
        PQclear(res);
        exit(1);
    }
}

void stampaContenuto(PGresult* res, int tuple,int campi){
    for(int i=0; i<campi; ++i){
        cout << std::setw(20) << std::left << PQfname(res,i) ;
    }
    cout << endl;

    cout << std::setfill('-') << std::setw(20*campi) << "-" << endl;
    cout << std::setfill(' ');

    for (int i=0; i<tuple; ++i){
        for ( int j=0; j<campi; ++j){
            cout << std::setw(20) << std::left << PQgetvalue (res,i,j);
        }
        cout << endl;
    }
}

//0-utente, 1-password, 2-DBname, 3-IP, 4-porta
int main(int argc, char* argv[]) {
    if (argc != 6) {
        cout << "Parametri non corretti.\nParametri da inserire: username password DBname IP porta";
    }

    char conninfo[250];
    sprintf(conninfo, "user=%s password=%s dbname=%s hostaddr=%s port=%s", argv[1], argv[2], argv[3], argv[4], argv[5]);
    PGconn *conn;
    conn = PQconnectdb(conninfo);

    if (PQstatus(conn) != CONNECTION_OK) {
        cout << "Errore di connessione.\n" << PQerrorMessage(conn);
        PQfinish(conn);
        exit(1);
    }
    cout << "Connessione al database avvenuta correttamente." << endl;

    PGresult *res;
    int tuple, campi;



    //QUERY 1 ////////////////////////////
    cout << "QUERY 1" << endl;
    const char *query = "select username as \"Proprietario\", f.nome as \"Nome feed\", i.sub as \"Sub incluso\" from "
                        "utente u join feed f on u.username=f.utente join include i on (f.nome=i.feed and f.utente=i.utente) "
                        "group by username, f.nome, i.sub order by username, f.nome;";

    res = PQexec(conn,query);
    checkResults(res,conn);

    tuple = PQntuples(res);
    campi = PQnfields(res);

    stampaContenuto(res,tuple,campi);

    PQclear(res);
    //////////////////////////////////////



    //QUERY 2 ////////////////////////////
    cout << endl << endl << "QUERY 2" << endl;
    const char *query2 = "select s.nome as \"Sub\", (select count(*) from post p where p.sub=s.nome group by s.nome) as "
                        "\"Numero post\", (select count(*) from commento c, post p where c.post=p.id and p.sub=s.nome "
                        "group by s.nome) as \"Numero commenti\" from sub s;";

    res = PQexec(conn,query2);
    checkResults(res,conn);

    tuple = PQntuples(res);
    campi = PQnfields(res);

    stampaContenuto(res,tuple,campi);
    PQclear(res);
    //////////////////////////////////////

    //QUERY 3 ////////////////////////////
    cout << endl << endl << "QUERY 3" << endl;
    const char *query3 = "drop view if exists votiPostUtente; create view votiPostUtente as select username, sum(valore) "
                         "as votiPost from utente u join votoPost v on u.username=v.utente group by username; drop view "
                         "if exists votiCommentoUtente; create view votiCommentoUtente as select username, sum(valore) "
                         "as votiCommento from utente u join votoCommento v on u.username=v.utente group by username; "
                         "select u.username, coalesce(votiPost+votiCommento, 0) as karma from utente u left join "
                         "votiPostUtente vp on u.username=vp.username left join votiCommentoUtente vc on "
                         "u.username=vc.username group by u.username, votiPost, votiCommento order by karma desc;";
    res = PQexec(conn,query3);
    checkResults(res, conn);

    tuple = PQntuples(res);
    campi = PQnfields(res);

    stampaContenuto(res,tuple,campi);
    PQclear(res);
    //////////////////////////////////////

    //QUERY 4 ////////////////////////////
    cout << endl << endl << "QUERY 4" << endl;
    const char *query4 ="drop view if exists mediaVotiSub; create view mediaVotiSub as select nome, cast(avg(numeroVoti) "
                        "as decimal(100,2)) as media from sub s join post p on s.nome=p.sub group by s.nome; select s.nome, "
                        "(select media from mediaVotiSub m where m.nome=s.nome), username, p.numeroVoti as voto from utente "
                        "u join post p on u.username=p.creatore join sub s on p.sub=s.nome where p.numeroVoti>(select "
                        "media from mediaVotiSub m where m.nome=s.nome) order by (s.nome, p.numeroVoti);";
    res = PQexec(conn,query4);
    checkResults(res,conn);

    tuple = PQntuples(res);
    campi = PQnfields(res);

    stampaContenuto(res,tuple,campi);
    PQclear(res);
    //////////////////////////////////////

    //QUERY 5 ////////////////////////////
    cout << endl << endl << "QUERY 5" << endl;
    const char *query5 = "drop view if exists numeroBanPerModeratore; create view numeroBanPerModeratore as select m.sub, "
                         "m.utente, count(*) as numeroBan from moderatore m join ban b on (m.utente=b.moderatore and "
                         "m.sub=b.modSub) group by m.sub, m.utente; select s.nome, m.utente as moderatore, numeroBan "
                         "from sub s join moderatore m on s.nome=m.sub join numeroBanPerModeratore n on "
                         "(n.utente=m.utente and n.sub=s.nome) order by s.nome, m.utente;";
    res = PQexec(conn,query5);

    tuple = PQntuples(res);
    campi = PQnfields(res);

    stampaContenuto(res,tuple,campi);
    PQclear(res);
    //////////////////////////////////////

    //QUERY 6 ////////////////////////////
    cout << endl << endl << "QUERY 6" << endl;
    const char* query6 = "drop view if exists numeroCommentiPost; create view numeroCommentiPost as select p.id, count(*) "
                         "as \"commenti\" from post p join commento c on p.id=c.post group by p.id; select m.tipo, titolo, "
                         "creatore, numeroVoti as \"voti\", commenti from numeroCommentiPost n join post p on n.id=p.id "
                         "join media m on p.id=m.id where tag like '%funny%';";
    res = PQexec(conn, query6);
    checkResults(res, conn);

    tuple = PQntuples(res);
    campi = PQnfields(res);

    stampaContenuto(res,tuple,campi);
    PQclear(res);
    //////////////////////////////////////

    PQfinish(conn);
    return 0;
}
