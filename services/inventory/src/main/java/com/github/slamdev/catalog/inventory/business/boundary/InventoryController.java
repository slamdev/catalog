package com.github.slamdev.catalog.inventory.business.boundary;

import lombok.Builder;
import lombok.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.stream.IntStream;

import static java.util.stream.Collectors.toList;

@RestController
@RequestMapping
public class InventoryController {

    @GetMapping("product")
    public List<Product> getProduct() {
        return IntStream.range(0, 20)
                .mapToObj(i -> Product.builder()
                        .id(i)
                        .name("Product #" + i)
                        .description("Description #" + i)
                        .imageUrl("https://developers.chrome.com/extensions/examples/api/idle/idle_simple/sample-128.png")
                        .build())
                .collect(toList());
    }

    @Value
    @Builder
    private static class Product {
        long id;
        String name;
        String description;
        String imageUrl;
    }
}
