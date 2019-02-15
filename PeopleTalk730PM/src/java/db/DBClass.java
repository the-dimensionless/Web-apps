
package db;
import java.sql.*;
public class DBClass {
    private Connection con;
    private Statement st;
     public Statement getSt() {
        return st;
    }
    private PreparedStatement getFile,getMsg,insertMsg,insertUser,checkLogin,getUser,changePhoto,getUsersByLocation;
    public DBClass(){
        try{
 Class.forName("com.mysql.jdbc.Driver");
 con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ptalk","root","incapp");
 st=con.createStatement();
 getFile=con.prepareStatement("select fname,ufile from people_msg where pid=?");
 getMsg=con.prepareStatement("select * from people_msg where sid=? and rid=?");
 insertMsg=con.prepareStatement("insert into people_msg (sid,rid,date,msg,fname,ufile) values (?,?,now(),?,?,?)");
 insertUser=con.prepareStatement("insert into user_info values (?,?,?,?,?,?,?,?,?,?)");
 checkLogin=con.prepareStatement("select * from user_info where email=? and pass=?");
 getUser=con.prepareStatement("select * from user_info where email=?");
 changePhoto=con.prepareStatement("update user_info set photo=? where email=?");
 getUsersByLocation=con.prepareStatement("select * from user_info where state=? and city=? and area like ? and email !=?");
 
        }catch(Exception ex){
            ex.printStackTrace();
        }
    }
    public ResultSet getFile(int p){
        try{        
getFile.setInt(1, p);
ResultSet r=getFile.executeQuery();
if(r.next()){
    return r;
}else{
    return null;
}
        }catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }
    public ResultSet getMsg(String s, String r){
        try{        
getMsg.setString(1, s);
getMsg.setString(2, r);
ResultSet rs=getMsg.executeQuery();
return rs;
        }catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }
    public String insertMsg(String s,String r,String m,String fn,java.io.InputStream in) {
        try{        
 insertMsg.setString(1, s);
 insertMsg.setString(2, r);
 insertMsg.setString(3, m);
 insertMsg.setString(4, fn);
 insertMsg.setBinaryStream(5, in);
int x=insertMsg.executeUpdate();
if(x==1)
 return "Done";
else 
 return "Error";
        }catch(Exception ex){
            ex.printStackTrace();
            return "Exception";
        }
    }
    public ResultSet getUsersByLocation(String s,String c,String a,String e){
        try{        
getUsersByLocation.setString(1, s);
getUsersByLocation.setString(2, c);
getUsersByLocation.setString(3, "%"+a+"%");
getUsersByLocation.setString(4, e);
ResultSet r=getUsersByLocation.executeQuery();
return r;
        }catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }
    public String changePhoto(String e,java.io.InputStream im) {
        try{        
 changePhoto.setString(2, e);
 changePhoto.setBinaryStream(1, im);
int x=changePhoto.executeUpdate();
if(x==1)
 return "Done";
else 
 return "Error";
        }catch(Exception ex){
            ex.printStackTrace();
            return "Exception";
        }
    }
    public ResultSet getUser(String e){
        try{        
getUser.setString(1, e);
ResultSet r=getUser.executeQuery();
if(r.next()){
    return r;
}else{
    return null;
}
        }catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }
    public String insertUser(String e,String p,String n,String ph,String gen,java.sql.Date d,String s,String c,String a,java.io.InputStream im) {
        try{        
 insertUser.setString(1, e);
 insertUser.setString(2, n);
 insertUser.setString(3, ph);
 insertUser.setString(4, gen);
 insertUser.setString(9, p);
 insertUser.setDate(5, d);
 insertUser.setString(6, s);
 insertUser.setString(7, c);
 insertUser.setString(8, a);
 insertUser.setBinaryStream(10, im);
int x=insertUser.executeUpdate();
if(x==1)
 return "Done";
else 
 return "Error";
        }catch(java.sql.SQLIntegrityConstraintViolationException ex){
            ex.printStackTrace();
            return "Already";
        }catch(Exception ex){
            ex.printStackTrace();
            return "Exception";
        }
    }
    public ResultSet checkLogin(String e,String p){
        try{        
checkLogin.setString(1, e);
checkLogin.setString(2, p);
ResultSet r=checkLogin.executeQuery();
if(r.next()){
    return r;
}else{
    return null;
}
        }catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }
}
