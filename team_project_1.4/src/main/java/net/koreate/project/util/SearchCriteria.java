package net.koreate.project.util;

public class SearchCriteria extends Criteria {

	private String searchType; // 검색 유형
	private String keyword; // 검색 내용

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	@Override
	public String toString() {
		return super.toString() + " SearchCriteria [searchType=" + searchType + ", keyword=" + keyword + "]";
	}

}