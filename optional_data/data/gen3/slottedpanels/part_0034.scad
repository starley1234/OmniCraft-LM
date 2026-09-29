$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 150 x 100 mm, 5 рядов of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 150;            // panel width
panel_d = 100;            // panel depth
thick = 5;                // panel thickness
slot_w = 7;               // slot width
pitch0 = 13;              // first row pitch
pitch_step = 1.2;         // pitch increase per row
margin = 10;              // margin around the slot field
rows = 5;                 // number of slot rows
mount_d = 5.4;            // mounting holes
mount_x = 63;             // mounting hole offset
rim_h = 12;               // rim height
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
  /* row 0: pitch 13, length 91 */
  hull() {
    translate([29.5, 13.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([120.5, 13.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 14.2, length 97.5 */
  hull() {
    translate([26.25, 26.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([123.75, 26.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 15.4, length 104 */
  hull() {
    translate([23, 40.7, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([127, 40.7, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 16.6, length 110.5 */
  hull() {
    translate([19.75, 56.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([130.25, 56.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 4: pitch 17.8, length 117 */
  hull() {
    translate([16.5, 72.7, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([133.5, 72.7, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([12, 5, -2.5]) cylinder(h = 17, d = mount_d);
  translate([12, 95, -2.5]) cylinder(h = 17, d = mount_d);
  translate([138, 5, -2.5]) cylinder(h = 17, d = mount_d);
  translate([138, 95, -2.5]) cylinder(h = 17, d = mount_d);
}
