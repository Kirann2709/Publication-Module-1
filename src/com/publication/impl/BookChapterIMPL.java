package com.publication.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.ResultSetHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import com.publication.constants.GeneratePCN;
import com.publication.dao.BookChapterDAO;
import com.publication.database.ConnectionFactory;
import com.publication.database.DataSourceFactory;
import com.publication.model.BookChapter;

public class BookChapterIMPL implements BookChapterDAO {

	@Override
	public boolean saveBookChapter(BookChapter bookChapter) {
		// TODO Auto-generated method stub
		if (bookChapter == null) {
			return false;
		}
		Connection connection = null;
		PreparedStatement ps = null;
		try {
			connection = ConnectionFactory.getConnection();
			ps = connection.prepareStatement(
					"insert into book_chapter (nameOauthors, deptt, chapterNo, chapterTitle, bookTitle, publisher, nationality, year, monthPublished, pageNo, isbn, hyperLink, indexFlag, indexLink, status) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			ps.setString(1, bookChapter.getNameOauthors());
			ps.setString(2, bookChapter.getDeptt());
			ps.setInt(3, bookChapter.getChapterNo());
			ps.setString(4, bookChapter.getChapterTitle());
			ps.setString(5, bookChapter.getBookTitle());
			ps.setString(6, bookChapter.getPublisher());
			ps.setString(7, bookChapter.getNationality());
			ps.setInt(8, bookChapter.getYear());
			ps.setString(9, bookChapter.getMonthPublished());
			ps.setInt(10, bookChapter.getPageNo());
			ps.setString(11, bookChapter.getIsbn());
			ps.setString(12, bookChapter.getHyperLink());
			ps.setString(13, bookChapter.getIndexFlag());
			ps.setString(14, bookChapter.getIndexLink());
			ps.setInt(15, bookChapter.getStatus());
			if (ps.executeUpdate() > 0) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionFactory.close(connection);
		}
		return false;
	}

	@Override
	public boolean updateBookChapter(BookChapter bookChapter) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public List<BookChapter> getAllBookChapters() throws SQLException {
		Connection connection = null;
		PreparedStatement ps = null;
		List<BookChapter> list = new ArrayList<>();
		try {
			connection = ConnectionFactory.getConnection();
			ps = connection.prepareStatement("select * from book_chapter");
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				BookChapter bc = new BookChapter();
				bc.setPcn(rs.getString("pcn"));
				bc.setNameOauthors(rs.getString("nameOauthors"));
				bc.setDeptt(rs.getString("deptt"));
				bc.setChapterNo(rs.getInt("chapterNo"));
				bc.setChapterTitle(rs.getString("chapterTitle"));
				bc.setBookTitle(rs.getString("bookTitle"));
				bc.setPublisher(rs.getString("publisher"));
				bc.setNationality(rs.getString("nationality"));
				bc.setYear(rs.getInt("year"));
				bc.setMonthPublished(rs.getString("monthPublished"));
				bc.setMonthOfPCN(rs.getString("monthAssigned"));
				bc.setPageNo(rs.getInt("pageNo"));
				bc.setIsbn(rs.getString("isbn"));
				bc.setHyperLink(rs.getString("hyperLink"));
				bc.setIndexFlag(rs.getString("indexFlag"));
				bc.setIndexLink(rs.getString("indexLink"));
				bc.setStatus(rs.getInt("status"));
				list.add(bc);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionFactory.close(connection);
		}
		return list;
	}

	@Override
	public BookChapter getBookChapterByPCN() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean delete(String pcn) {
		// TODO Auto-generated method stub
		return false;
	}

	public static void main(String[] args) {
		BookChapterDAO dao = new BookChapterIMPL();
		try {
			System.out.println(dao.getAllBookChapters());
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public boolean approve(String deptt, String bookTitle, String chapterTitle, String chapterNo, String publisher,
			String isbn, int status) {
		Connection connection;
		PreparedStatement ps1, ps2;
		ArrayList<Integer> list = new ArrayList<>(); 
		try {
			connection = ConnectionFactory.getConnection();
			ps1 = connection.prepareStatement("select pcn from book_chapter where pcn like \"%B___\"");
			ResultSet rs = ps1.executeQuery();
			String pcn;
			if(!rs.next()){
				pcn = GeneratePCN.generatePCN(deptt, "B", 0);
			}else{
				rs.previous();
				while(rs.next()){
					String result = rs.getString("pcn");
					Pattern pattern = Pattern.compile("[0-9]{3}");
					Matcher matcher = pattern.matcher(result);
					if(matcher.matches()){
						list.add(Integer.parseInt(result.substring(matcher.start(),matcher.end())));					}
				}
				int[] array = list.stream().mapToInt(i->i).toArray();
				int sno = getMissing(array, array.length);
				pcn = GeneratePCN.generatePCN(deptt, "B", sno);
			}
			Calendar cal = Calendar.getInstance();
			String month = new SimpleDateFormat("MMM").format(cal.getTime());
			ps2 = connection.prepareStatement("update book_chapter set pcn=?, monthAssigned=?, status=? where deptt=? and bookTitle=? and chapterTitle=? and chapterNo=? and isbn =?");
			ps2.setString(1, pcn);
			ps2.setString(2, month);
			ps2.setInt(3, status);
			ps2.setString(4, deptt);
			ps2.setString(5, bookTitle);
			ps2.setString(6, chapterTitle);
			ps2.setString(7, chapterNo);
			ps2.setString(8, isbn);
			if(ps2.executeUpdate()>0){
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

	int getMissing(int a[], int n) {
		int i, total;
		total = (n + 1) * (n + 2) / 2;
		for (i = 0; i < n; i++)
			total -= a[i];
		return total;
	}

}
