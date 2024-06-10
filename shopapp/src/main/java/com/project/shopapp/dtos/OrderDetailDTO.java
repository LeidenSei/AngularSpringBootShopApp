package com.project.shopapp.dtos;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.Min;
import lombok.*;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class OrderDetailDTO {
    @JsonProperty("order_id")
    @Min(value = 1, message = "Order's Id must be >0")
    private Long orderId;

    @JsonProperty("product_id")
    @Min(value = 1, message = "Product's Id must be >0")
    private Long productId;

    @Min(value = 0, message = "Price's Id must be >0")
    private float price;

    @JsonProperty("number_of_product")
    @Min(value = 1, message = "number_of_products must be >1")
    private int numberOfProducts;

    @Min(value = 1, message = "total_money's Id must be >0")
    @JsonProperty("total_money")
    private float totalMoney;

    private String color;
}
