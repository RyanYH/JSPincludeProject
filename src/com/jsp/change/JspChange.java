package com.jsp.change;

//JavaBean
// - ActionBean
public class JspChange {
	private static String[] jsp={
		"../main/default.jsp",
		"../member/join.jsp",
		"../board/list.jsp",
		"../board/content.jsp",
		"../board/insert.jsp",
		"../board/update.jsp",
		"../board/reply.jsp",
		"../board/find.jsp",
		"../member/join_yes.jsp",
		"../databoard/list.jsp",
		"../databoard/insert.jsp",  //10
		"../databoard/content.jsp", 
		"../member/m_update.jsp",
		"../databoard/update.jsp",
		"../movie/list.jsp",
		"../movie/Detail.jsp"       //15
	};
	public static String jspChange(int no){
		return jsp[no];
	}
}
