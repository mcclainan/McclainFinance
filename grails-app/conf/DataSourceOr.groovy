dataSource {
    pooled = true
    
}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = true
    cache.provider_class = 'net.sf.ehcache.hibernate.EhCacheProvider'
}
// environment specific settings
environments {
    development {
        dataSource {
			driverClassName = "org.hsqldb.jdbcDriver"
			username = "sa"
			password = ""
            dbCreate = "create-drop" // one of 'create', 'create-drop','update'
            url = "jdbc:hsqldb:file:devDB;shutdown=true"
        }
    }
   test {
        dataSource {
			driverClassName = "oracle.jdbc.driver.OracleDriver"
			dialect = "org.hibernate.dialect.Oracle10gDialect"
			username = "MAC_FIN_TEST"
			password = "TONY2505"
            dbCreate = "create-drop"
            url = "jdbc:oracle:thin:@localhost:1521:XE"
        }
    }
    production {
        dataSource {
			driverClassName = "oracle.jdbc.driver.OracleDriver"
			dialect = "org.hibernate.dialect.Oracle10gDialect"
			username = "MAC_FIN_ADMIN"
			password = "tony2505"
			dbCreate = "update" // one of 'create', 'create-drop','update'
			url = "jdbc:oracle:thin:@173.30.232.160:1521:XE"
        }
    }
}
