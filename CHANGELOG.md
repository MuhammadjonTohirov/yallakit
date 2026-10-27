<!--
  CHANGELOG.md
  YallaKit

  Created by Muhammadjon Tohirov on 15/10/26.
-->

# Changelog

## 3.0.0 — 2026-10-27

- Re-export YallaDomain 3.0.0. Executor timeout and distance are optional; missing heading defaults to zero.

## 2.0.0 — 2026-10-15

- Re-export YallaDomain 2.0.0 and require YallaNetwork 1.0.1, making the corrected order response contracts available through YallaKit.
- Align `IldamKit.version` with the package release.

Consumer migration: replace removed `OrderTaxiDetails.tariff` and `.routes` accesses with order-level fields, remove those taxi initializer arguments, and treat award amounts as `Double`.
