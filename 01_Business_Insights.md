# Business Insights — Retail Sales & Inventory Analytics

## Executive Summary

The dataset covers ₦3,574,837,300 in revenue across 35,647 units sold (Jul 2025–Jun 2026) across three branches. The core finding: the "declining sales" pattern is not a business-wide trend — it is a single-branch, single-brand problem. Mbari's revenue fell 44.6% between its first and last tracked quarter, driven almost entirely by a 65.8% collapse in Huawei sales network-wide, concentrated at Mbari (Huawei revenue there fell from ₦64.5M/month to ₦4.3M/month — a 93% drop). Owerri Main and Tetlow declined only 4.0% and 6.4% respectively over the same window.

On inventory, the same root cause reappears as overstock: 8 of Mbari's SKUs carry 90+ days of unsold supply (five of them Huawei models), tying up roughly ₦227.9M in dead capital network-wide. In parallel, 22 SKUs are within 14 days of stocking out, and 36 SKUs have less runway than their supplier lead time — meaning they will likely stock out before a reorder can arrive.

## Branch Performance

| Branch | Total Revenue | Units | Avg Order Value | Q1→Q4 Change |
|---|---|---|---|---|
| Tetlow | ₦1.45B | 14,991 | ₦96,519 | -6.4% |
| Mbari | ₦1.11B | 9,959 | ₦111,707 | **-44.6%** |
| Owerri Main | ₦1.02B | 10,697 | ₦94,927 | -4.0% |

Tetlow leads on both revenue and volume and is the most resilient branch. Mbari carries the highest average order value (a premium product mix) but has lost nearly half its revenue over the tracked year — this is the branch that needs intervention, not the network as a whole.

## What Is Actually Declining

- **By category**: Mobile Phones -19.9% vs. Phone Accessories -6.1%. The core product line is the problem, not accessories.
- **By brand**: Huawei -65.8% dwarfs every other brand's decline (next worst is Tecno at -9.4%). Every other brand sits in single digits.
- **By branch concentration**: Huawei revenue is heavily weighted to Mbari (₦413M there vs. ₦88M at Owerri Main and ₦128M at Tetlow) — the brand collapse and the branch collapse are the same event viewed from two angles.
- **Weekday pattern**: Monday is a consistently soft day (avg ₦123K/day vs. ₦168–182K on other days) — worth checking against restock/staffing schedules rather than treating it as a demand issue.

## Inventory Management

- **Overstock (>90 days of supply)**: 12 SKUs, ₦227.9M in tied-up capital, concentrated at Mbari (8 SKUs, mostly Huawei: Nova 11i, Nova 12i, Y9 Prime, Nova Y61, Y5p). The single worst SKU — Huawei Nova 11i at Mbari — alone holds 348 units and 3,480 days of supply, worth ₦71.7M.
- **Stockout risk (<14 days of supply)**: 22 SKUs, spread fairly evenly across branches, mostly fast-moving accessories and entry-level phones (Itel, Redmi, generic accessories).
- **Reorder risk (days of supply < supplier lead time)**: 36 SKUs will likely stock out before a fresh order can physically arrive. Owerri Main carries the most exposure (18 of the 36), which is notable because its sales are otherwise stable — this is a process gap (reorder points/lead-time buffers), not a demand problem.
- No true dead stock was found (zero velocity with stock still on hand) — every SKU is moving, some far too slowly relative to what is sitting in the warehouse.

## Risk vs. Opportunity

| Area | Risk if ignored | Opportunity if acted on |
|---|---|---|
| Huawei at Mbari | Continued markdown pressure; more capital trapped in unsellable stock | Liquidate/return excess stock; reallocate shelf space and capital toward Tecno/Infinix, which are stable-to-growing |
| Mbari branch overall | Revenue erosion continues if the root cause is misdiagnosed as a branch-wide problem | Once Huawei exposure is corrected, Mbari's non-Huawei business is only mildly down — a targeted fix, not a branch overhaul |
| Reorder-risk SKUs (36) | Stockouts on fast movers, lost sales, customer walk-aways | Tightening lead-time buffers protects revenue at near-zero cost |
| Overstock capital (₦227.9M) | Cash tied up, storage cost, obsolescence risk as newer models launch | Freeing this capital could fund restocking of the 22 at-risk SKUs several times over |

## Recommended Actions

1. Confirm with branch management whether Mbari's Huawei decline reflects a distributor supply cut, a demand shift, or a pricing/competitor issue — this determines whether the fix is procurement or marketing.
2. Prioritize liquidating the ₦71.7M tied up in the single worst SKU (Huawei Nova 11i, Mbari) as a first action.
3. Tighten reorder points at Owerri Main specifically — its 18 reorder-risk SKUs are the largest concentration despite stable sales.
4. Monitor the Monday revenue dip against staffing/restock schedules to confirm whether it is operational or genuine demand softness.
