package com.sist.mapper;

import org.apache.ibatis.annotations.Insert;

import com.sist.vo.*;
import java.util.*;

public interface BannerMapper {
	@Insert("INSERT INTO promotion_banner VALUES((SELECT NVL(MAX(pbno)+1, 1)), #{title}, #{userid}, #{stack}, #{wno}, #{type}, #{startDay}, #{endDay}, 0)")
	public void promotionBannerInput(PromotionBannerVO vo);
}
