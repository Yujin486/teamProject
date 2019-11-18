package net.koreate.project.util;

public class Criteria {
	
	private int page;
	private int perPageNum;
	
	public Criteria() {
		this(1, 10);
	}
	
	public Criteria(int page, int perPageNum) {
		this.page=page;
		this.perPageNum=perPageNum;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		if(page < 1) {
			this.page=1;
			return;
		}
		this.page=page;
	}

	public int getPerPageNum() {
		return perPageNum;
	}

	public void setPerPageNum(int perPageNum) {
		if(perPageNum < 1 || perPageNum > 100) {
			this.perPageNum=10;
			return;
		}
		this.perPageNum = perPageNum;
	}
	
	public int getPageStart() {
		return (this.page-1)*perPageNum;
	}

	@Override
	public String toString() {
		return "Criteria [page=" + page + ", perPageNum=" + perPageNum + "]";
	}
	
}
