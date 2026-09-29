$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 150 x 70 mm, 5 рядов of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 150;            // panel width
panel_d = 70;             // panel depth
thick = 6;                // panel thickness
slot_w = 5;               // slot width
pitch0 = 9;               // first row pitch
pitch_step = 1.2;         // pitch increase per row
margin = 10;              // margin around the slot field
rows = 5;                 // number of slot rows
mount_d = 6.6;            // mounting holes
mount_x = 63;             // mounting hole offset
rim_h = 11;               // rim height
rim_t = 4;                // rim wall thickness

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
    translate([0, 0, thick - 1]) difference() {
      cube([panel_w, panel_d, rim_h - thick + 1]);
      translate([rim_t, rim_t, -2.5]) cube([panel_w - 2 * rim_t, panel_d - 2 * rim_t, rim_h - thick + 6]);
    }
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 9, length 91 */
  hull() {
    translate([29.5, 12.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([120.5, 12.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 10.2, length 97.5 */
  hull() {
    translate([26.25, 21.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([123.75, 21.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 11.4, length 104 */
  hull() {
    translate([23, 31.7, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([127, 31.7, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 12.6, length 110.5 */
  hull() {
    translate([19.75, 43.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([130.25, 43.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 4: pitch 13.8, length 117 */
  hull() {
    translate([16.5, 55.7, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([133.5, 55.7, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([12, 5, -2.5]) cylinder(h = 16, d = mount_d);
  translate([12, 65, -2.5]) cylinder(h = 16, d = mount_d);
  translate([138, 5, -2.5]) cylinder(h = 16, d = mount_d);
  translate([138, 65, -2.5]) cylinder(h = 16, d = mount_d);
}
