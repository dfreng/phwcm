package com.unism.web.action.product;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.annotation.Resource;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.unism.bean.product.ProductType;
import com.unism.bean.util.QueryResult;
import com.unism.service.product.inter.ProductTypeService;
import com.unism.web.formbean.product.ProductTypeVO;

@Controller
public class ProductTypeAction extends ActionSupport implements
		ModelDriven<ProductTypeVO> {
	
	@Resource(name = "productTypeServiceBean")
	private ProductTypeService productTypeService;
	private ProductTypeVO productTypeVO = new ProductTypeVO();
	/**
	 * 
	 */
	private static final long serialVersionUID = -8223000769614998L;

	@Override
	public ProductTypeVO getModel() {
		return productTypeVO;
	}
	
	@Override
	public String execute() throws Exception {
		// TODO Auto-generated method stub
		return super.execute();
	}

	public String list () {
		int maxResult = 5;
		if (productTypeVO.getRows() != null) {
			maxResult = Integer.valueOf(productTypeVO.getRows().get(0).toString());
		}
		int firstIndex = ((productTypeVO.getPage() - 1) * maxResult);
		LinkedHashMap<String, String> orderBy = new LinkedHashMap<String, String>();
		orderBy.put("name", "desc");
		QueryResult<ProductType> qr = productTypeService.getScrollDate(ProductType.class,
				firstIndex, maxResult,orderBy);
		Map<String, Object> jsonMap = new HashMap<String, Object>();// 定义map
		productTypeVO.setTotal(20);
		productTypeVO.setResult(JSONArray.fromObject(qr.getResultList())); 
		JSONObject.fromObject(jsonMap);
		
		return SUCCESS;
	}

}
