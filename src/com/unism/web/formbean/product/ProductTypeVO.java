package com.unism.web.formbean.product;

import java.util.List;

import org.apache.struts2.json.annotations.JSON;

import net.sf.json.JSONArray;

import com.unism.web.formbean.base.BaseForm;
import com.unism.web.util.PageView;

public class ProductTypeVO extends BaseForm {
	/**
	 * 返回的json对象
	 */
	private JSONArray result;// 返回的json

	public JSONArray getResult() {
		return result;
	}

	public void setResult(JSONArray result) {
		this.result = result;
	}

	@Override
	public int getPage() {
		return super.getPage();
	}

	@Override
	public void setPage(int page) {
		super.setPage(page);
	}

	@Override
	public List<?> getRows() {
		return super.getRows();
	}

	@Override
	public void setRows(List<?> rows) {
		super.setRows(rows);
	}

	@Override
	public int getTotal() {
		return super.getTotal();
	}

	@Override
	public void setTotal(int total) {
		super.setTotal(total);
	}

}
