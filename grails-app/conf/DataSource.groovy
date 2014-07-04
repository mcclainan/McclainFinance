dataSource {
    pooled = true
    driverClassName = "org.h2.Driver"
    username = "sa"
    password = ""
}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = false
    cache.region.factory_class = 'net.sf.ehcache.hibernate.EhCacheRegionFactory'
}
// environment specific settings
environments {
    development {
        dataSource {
            dbCreate = "create-drop" // one of 'create', 'create-drop', 'update', 'validate', ''
            url = "jdbc:h2:mem:devDb;MVCC=TRUE;LOCK_TIMEOUT=10000"
        }
    }
    test {
		dataSource {
			driverClassName = "oracle.jdbc.driver.OracleDriver"
			dialect = "org.hibernate.dialect.Oracle10gDialect"
			username = "MAC_FINANCIAL_TEST"
			password = "TONY2505"
			url = "jdbc:oracle:thin:@24.255.171.38:1521:XE"
			pooled = true
			properties {
			   maxActive = -1
			   minEvictableIdleTimeMillis=1800000
			   timeBetweenEvictionRunsMillis=1800000
			   numTestsPerEvictionRun=3
			   testOnBorrow=true
			   testWhileIdle=true
			   testOnReturn=true
			   validationQuery="SELECT 1 from dual"
			}
		}
    }
    production {
        dataSource {
            driverClassName = "oracle.jdbc.driver.OracleDriver"
			dialect = "org.hibernate.dialect.Oracle10gDialect"
			username = "MAC_FINANCIAL_ADMIN"
			password = "TONY2505"
            url = "jdbc:oracle:thin:@24.255.171.38:1521:XE"	
//            url = "jdbc:oracle:thin:@localhost:1521:XE"	
            pooled = true
            properties {
               maxActive = -1
               minEvictableIdleTimeMillis=1800000
               timeBetweenEvictionRunsMillis=1800000
               numTestsPerEvictionRun=3
               testOnBorrow=true
               testWhileIdle=true
               testOnReturn=true
               validationQuery="SELECT 1 from dual"
            }
        }
    }
}
