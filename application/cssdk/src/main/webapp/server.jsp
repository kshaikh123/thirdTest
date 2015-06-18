<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.net.URL"%>
<%@ page import="java.net.URLConnection"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page import="java.io.IOException"%>
<%@ page import="java.io.BufferedReader"%> 
<%@ page import="java.lang.management.ManagementFactory"%> 
<%@ page import="java.lang.management.RuntimeMXBean"%> 
<%@ page import="java.util.List"%> 
<%
response.setHeader("Cache-Control","no-cache"); 
response.setHeader("Pragma","no-cache"); 
response.setDateHeader ("Expires", -1); 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Instance Information and Logs</title>
        <style type="text/css">
            body {
                font-family: Arial, Verdana, sans-serif;
                font-size: 90%;
                color: #666666;
                background-color: #f8f8f8;}
            li {
                line-height: 1.6em;}
            table {
                border-spacing: 0px;}
            th, td {
                padding: 5px 5px 5px 5px;
                border-spacing: 0px;
                font-size: 90%;
                margin: 0px;}
            th, td {
                text-align: left;
                background-color: #e0e9f0;
                border-top: 1px solid #f1f8fe;
                border-bottom: 1px solid #cbd2d8;
                border-right: 1px solid #cbd2d8;}
            tr.head th {
                color: #fff;
                background-color: #90b4d6;
                border-bottom: 2px solid #547ca0;
                border-right: 1px solid #749abe;
                border-top: 1px solid #90b4d6;
                text-align: center;
                text-shadow: -1px -1px 1px #666666;
                letter-spacing: 0.15em;}
            td {
                text-shadow: 1px 1px 1px #ffffff;}
            tr.even td, tr.even th {
                background-color: #e8eff5;}
            tr.head th:first-child {
                -webkit-border-top-left-radius: 5px;
                -moz-border-radius-topleft: 5px;
                border-top-left-radius: 5px;}
            tr.head th:last-child {
                -webkit-border-top-right-radius: 5px;
                -moz-border-radius-topright: 5px;
                border-top-right-radius: 5px;}
            fieldset {
                width: 310px;
                margin-top: 20px;
                border: 1px solid #d6d6d6;
                background-color: #ffffff;
                line-height: 1.6em;}
            legend {
                font-style: italic;
                color: #666666;}
            input[type="text"] {
                width: 120px;
                border: 1px solid #d6d6d6;
                padding: 2px;
                outline: none;}
            input[type="text"]:focus,
            input[type="text"]:hover {
                background-color: #d0e2f0;
                border: 1px solid #999999;}
            input[type="submit"] {
                border: 1px solid #006633;
                background-color: #009966;
                color: #ffffff;
                border-radius: 5px;
                padding: 5px;
                margin-top: 10px;}
            input[type="submit"]:hover {
                border: 1px solid #006633;
                background-color: #00cc33;
                color: #ffffff;
                cursor: pointer;}
            .title {
                float: left;
                width: 160px;
                clear: left;}
            .submit {
                width: 310px;
                text-align: right;}
        </style>
    </head>
    <body>
<%!
public String getURLOutput(String urlString) {
    BufferedReader in = null;
    String data = "";
    try { 
        URL url = new URL(urlString);
        URLConnection yc = url.openConnection();
        in = new BufferedReader(new InputStreamReader(
                yc.getInputStream()));
        String tempLine;
        while ((tempLine = in.readLine()) != null)
            data=data+tempLine;  
    }
    catch(Exception e) {
        
    }
    finally {
        try {
            in.close();
        } catch (IOException e) { 
            e.printStackTrace();
        }
    }
    return data;
}
%>
        <h1>Instance Information:</h1>  
        <table>
          <tr class="head"> 
                <th>Instance Info</th>
                <th>Server info</th> 
            </tr>
          <tr>
            <td>
<%
String instanceId = getURLOutput("http://169.254.169.254/latest/meta-data/instance-id");
String hostName = getURLOutput("http://169.254.169.254/latest/meta-data/public-hostname");
String ip = getURLOutput("http://169.254.169.254/latest/meta-data/public-ipv4");
%>
                <table cellpadding="1"> 
                    <tr>
                        <th>Public Instance Id</b></th>
                        <td><%= instanceId%></td> 
                    </tr>
                    <tr class="even">
                        <th>Public Host Name</b></th>
                        <td><%= hostName%></td> 
                    </tr>
                    <tr>
                        <th><b>Public IP</b></th>
                        <td><%= ip%></td> 
                    </tr>
                </table>
            </td>
            <td>
<%
String processors = Runtime.getRuntime().availableProcessors()+"";
String freeMemory = Runtime.getRuntime().freeMemory()+"";
long maxMemory = Runtime.getRuntime().maxMemory();
%>
                <table> 
                    <tr>
                        <th>Processors</b></th>
                        <td><%= processors%></td> 
                    </tr>
                    <tr class="even">
                        <th>Free memory</b></th>
                        <td><%= freeMemory%></td> 
                    </tr>
                    <tr>
                        <th><b>Maximum memory</b></th>
                        <td><%= maxMemory%></td> 
                    </tr> 
                </table>
            </td> 
          </tr> 
        </table>
        <p>Configuration Parameters:</p>    
         <ul>
        <%
          RuntimeMXBean bean = ManagementFactory.getRuntimeMXBean();
          List<String> aList = bean.getInputArguments();
          for (int i = 0; i < aList.size(); i++) { 
          %> 
            <li word-wrap: break-word><%= aList.get(i)%></li>
          <%
          } 
          %>
        </ul>
    </body>
</html>