<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	
		<meta charset="UTF-8">
		<%@ include file="./dbconn.jsp" %>
		<link rel="stylesheet" href = "./css/mem_list.css?after">
	
		<title>회원리스트</title>
	</head>
	<body>
		<%
			String opt=request.getParameter("opt");
			String search=request.getParameter("search") != null ? request.getParameter("search") : "";
			String male=request.getParameter("male") != null ? request.getParameter("male") : "";
			String female=request.getParameter("female") != null ? request.getParameter("female") : "";
			String SMSY=request.getParameter("SMSY") != null ? request.getParameter("SMSY") : "";
			String SMSN=request.getParameter("SMSN") != null ? request.getParameter("SMSN") : "";
			String emailY=request.getParameter("emailY") != null ? request.getParameter("emailY") : "";
			String emailN=request.getParameter("emailN") != null ? request.getParameter("emailN") : "";
		%>
		<button onclick = "location = 'login.jsp'" id = "main">홈</button>
		<h1>회원리스트</h1>
		<form name="SearchForm" action=memberlist_search.jsp method=get onSubmit="return validateForm();" style = "margin : 5px;">
			<table>
				<tr><td id = "search" colspan = "2">검색조건</td></tr>
				<tr>
					<td colspan = "2">
						<select name = "opt" id = "opt" style = "width: 77px;">
							<option value = "1">항목</option>
							<option value = "member_id"<% if(opt.equals("member_id")){%> selected<%}%>>ID</option>
							<option value = "member_name"<% if(opt.equals("member_name")){%> selected<%}%>>이름</option>
							<option value = "zipcode"<% if(opt.equals("zipcode")){%> selected<%}%>>우편번호</option>
							<option value = "lot_addr"<% if(opt.equals("lot_addr")){%> selected<%}%>>지번주소</option>
							<option value = "road_addr"<% if(opt.equals("road_addr")){%> selected<%}%>>도로명주소</option>
						</select>
						<input type = "text" name = "search" value = <%=search %>>
						<input type = "submit"  id = "submit" value = "검색">
					</td>
				</tr>
				<tr>
					<td class="cond">성별</td>
					<td>
						<input type = "checkbox" name = "male" value = "male" <% if(male.equals("male")){%> checked<%}%>>남자
						<input type = "checkbox" name = "female" value = "female" <% if(female.equals("female")){%> checked<%}%>>여자
					</td>
				</tr>
				<tr>
					<td class="cond">SMS수신</td>
					<td>
						<input type = "checkbox" name = "SMSY" value = "Y" <% if(SMSY.equals("Y")){%> checked<%}%>>허용
						<input type = "checkbox" name = "SMSN" value = "N" <% if(SMSN.equals("N")){%> checked<%}%>>미허용
					</td>
				</tr>
				<tr>
					<td class="cond">email수신</td>
					<td>
						<input type = "checkbox" name = "emailY" value = "Y" <% if(emailY.equals("Y")){%> checked<%}%>>허용
						<input type = "checkbox" name = "emailN" value = "N" <% if(emailN.equals("N")){%> checked<%}%>>미허용
					</td>
				</tr>
				</table>
			</form>
			
			<div style = "margin-top: 20px;">
				<button onclick = "location = 'memberlist.jsp'">전체 리스트보기</button>
			</div>
			<table border = "1" id = "list">
			<tr style = "background: #7D9D9C; color: white;">
				<td>num</td>
				<td>ID</td>
				<td>이름</td>
				<td>성별</td>
				<td>생년월일</td>
				<td>HP</td>
				<td>sms수신</td>
				<td>이메일</td>
				<td>메일수신</td>
				<td>우편번호</td>
				<td>지번주소</td>
				<td>도로명주소</td>
				<td>나머지주소</td>
				<td>가입날짜</td>
				<td>회원삭제</td>
			</tr>
			<% 
				int count = 0;
				int i = 1;
				
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				
				String sql = "SELECT * FROM shopping_member WHERE 1 = 1 ";
				
				if(!opt.equals("1")){
					sql += "and " + opt + " like '%" + search + "%'";
				}
				
				if(male.equals("male") && female.equals("female")){
					sql += "and (member_gender = '" + male + "'" +  "or member_gender = '" + female + "')";
				}else if(male.equals("male")){
					sql += "and member_gender = '" + male + "'";
				}else if(female.equals("female") ){
					sql += "and member_gender = '" + female + "'";
				}
				
				if(SMSY.equals("Y") && SMSN.equals("N")){
					sql += "and (SMS_YN = 'Y' or SMS_YN = 'N')";
				}else if(SMSY.equals("Y")){
					sql += "and SMS_YN = 'Y'";
				}else if(SMSN.equals("N")){
					sql += "and SMS_YN = 'N'";
				}else{
				}
		
				if(emailY.equals("Y") && emailN.equals("N")){
					sql += "and (emailsts_YN = 'Y' or emailsts_YN = 'N')";
				}else if(emailY.equals("Y")){
					sql += "and emailsts_YN = 'Y'";
				}else if(emailN.equals("N")){
					sql += "and emailsts_YN = 'N'";
				}else{
				}
				
				sql += "ORDER BY member_id ASC";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				
				while (rs.next()) {
					count++;
					String member_id = rs.getString("member_id");
					String name = rs.getString("member_name");
					String gender = rs.getString("member_gender");
					String birth_y = rs.getString("member_birth_y");
					String birth_m = rs.getString("member_birth_m");
					String birth_d = rs.getString("member_birth_d");
					String birth_gn = rs.getString("member_birth_gn");
					String HP1 = rs.getString("HP1");
					String HP2 = rs.getString("HP2");
					String HP3 = rs.getString("HP3");
					String SMS_YN = rs.getString("SMS_YN");
					String email1 = rs.getString("email1");
					String email2 = rs.getString("email2");
					String emailsts_YN = rs.getString("emailsts_YN");
					String DBzipcode = rs.getString("zipcode");
					String DBlot_addr = rs.getString("lot_addr");
					String DBroad_addr = rs.getString("road_addr");
					String DBrest_addr = rs.getString("rest_addr");
					String joindate = rs.getString("joindate");
			%>
	
			<tr>
				<td><%=i%></td>
				<td><%=member_id%></td>
				<td><%=name %></td>
				<td><%=gender %></td>
				<td><%=birth_y%>/<%=birth_m%>/<%=birth_d%>(<%=birth_gn%>)</td>
				<td><%=HP1%>-<%=HP2%>-<%=HP3%></td>
				<td><%=SMS_YN%></td>
				<td><%=email1%>@<%=email2%></td>
				<td><%=emailsts_YN%></td>
				<td><%=DBzipcode%></td>
				<td><%=DBlot_addr%></td>
				<td><%=DBroad_addr%></td>
				<td><%=DBrest_addr%></td>
				<td><%=joindate%></td>
				<td><button id = <%=member_id%> onclick = "mem_delete(this.id);">삭제</button></td>
			</tr>
			<%
				i++;
				}
				if(count == 0) {
					out.print("검색결과가 없습니다.");
				}
			%>
		</table> 
	</body>
</html>

<script>
	function mem_delete(id) {
		if (confirm(id + "님의 계정을 삭제하시겠습니까?") == true) {
			location.href="memberlist_delete.jsp?target=" + id;
		} else {
			return false;
		}
	}
</script>