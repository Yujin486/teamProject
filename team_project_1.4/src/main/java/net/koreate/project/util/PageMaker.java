package net.koreate.project.util;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

public class PageMaker {
	
	private int totalCount;
	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;
	private int displayPageNum=5;
	private int maxPage;
	
	Criteria cri;
	
	public void calPaging() {
		endPage = (int)(Math.ceil(cri.getPage()/(double)displayPageNum)) * displayPageNum;
		startPage = (endPage - displayPageNum)+1;
		maxPage = (int) Math.ceil(totalCount /(double)(cri.getPerPageNum()));
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		prev = (startPage == 1 ) ? false : true;
		
		next = (endPage * cri.getPerPageNum() < totalCount) ? true : false;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		calPaging();
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	public int getDisplayPageNum() {
		return displayPageNum;
	}

	public void setDisplayPageNum(int displayPageNum) {
		this.displayPageNum = displayPageNum;
	}

	public Criteria getCri() {
		return cri;
	}

	public void setCri(Criteria cri) {
		this.cri = cri;
	}
	
	public int getMaxPage() {
		return maxPage;
	}

	public void setMaxPage(int maxPage) {
		this.maxPage = maxPage;
	}

	public String makeSearchQuery(int page) {
		
		String keyWord = (((SearchCriteria)cri).getKeyword()); 
		
		if(keyWord != null && ! keyWord.equals("")) {
			try {
				keyWord = URLEncoder.encode(keyWord,"utf-8");
			} catch (UnsupportedEncodingException e) {}
		}
		
		UriComponents uc = UriComponentsBuilder.newInstance()
				.queryParam("page", page)
				.queryParam("perPageNum", cri.getPerPageNum())
				.queryParam("searchType", ((SearchCriteria)cri).getSearchType())
				.queryParam("keyword", keyWord)				
				.build();
		String query = uc.toString();
		System.out.println(query);
		return query;
	}

	@Override
	public String toString() {
		return "PageMaker [totalCount=" + totalCount + ", startPage=" + startPage + ", endPage=" + endPage + ", prev="
				+ prev + ", next=" + next + ", displayPageNum=" + displayPageNum + ", cri=" + cri + "]";
	}
	
	

}
