package com.trs.zhq.util;

import com.trs.hybase.client.TRSConnection;
import com.trs.hybase.client.TRSResultSet;
import com.trs.hybase.client.params.ConnectParams;

import java.io.IOException;
import java.util.Properties;

public class HybaseConnectionUtil {
	
	//连接hybase数据库
	public static TRSConnection getHybaseConnection(){
        Properties properties = new Properties();
        TRSConnection connection = null;
        
        try {
            properties.load(HybaseConnectionUtil.class.getClassLoader().getResourceAsStream("hybase.properties"));
            
            String url = properties.getProperty("hybaseUrl");
            String user = properties.getProperty("hybaseUser");
            String password = properties.getProperty("hybasePassword");
            
            connection = new TRSConnection(url,user,password,new ConnectParams());

        } catch (IOException e) {
            e.printStackTrace();
        }

        return connection;
    }
	
	//关闭hybase的连接
	public static void closeConnection(TRSConnection connection) {
		if(connection != null){
			connection.close();
		}
	}
	public static void closeResultSet(TRSResultSet resultSet) {
		if(resultSet != null){
			resultSet.close();
		}
	}

}
