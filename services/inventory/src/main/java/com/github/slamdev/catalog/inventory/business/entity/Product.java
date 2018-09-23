package com.github.slamdev.catalog.inventory.business.entity;

import lombok.*;
import lombok.experimental.FieldDefaults;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import java.time.Instant;
import java.util.UUID;

@Entity
@Builder(toBuilder = true)
@AllArgsConstructor(access = AccessLevel.PACKAGE)
@NoArgsConstructor(access = AccessLevel.PACKAGE)
@Setter(AccessLevel.PACKAGE)
@Getter
@EqualsAndHashCode(of = "id")
@ToString
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Product {

    @Id
    UUID id;

    @Column(nullable = false)
    String name;

    @Column(nullable = false)
    String description;

    @Column(nullable = false)
    String imageUrl;

    @CreatedDate
    @Column(nullable = false)
    Instant createdDate;

    @LastModifiedDate
    @Column(nullable = false)
    Instant lastModifiedDate;
}
