$fn = 32;

// ----------------------------------------------------------------------
// Honeycomb panel: 61.37 x 71.23 mm, 24 cells of 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 61.37;          // panel width
panel_d = 71.23;          // panel depth
thick = 8;                // panel thickness
cell_r = 5;               // hex cell circumradius
pitch = 10.26;            // hex cell pitch (centre to centre)
web = 1.6;                // web between the cells
columns = 4;              // columns of cells
rows = 6;                 // rows of cells
cell_count = 24;          // total cells
shift_x = 12.73;          // first cell offset in x
shift_y = 13.4;           // first cell offset in y
mount_d = 5.4;            // corner mounting holes
hole_off = 4.2;           // mounting hole offset from the corners
rim_h = 14;               // rim height
rim_t = 3;                // rim wall thickness

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
    /* rim around the panel, sunk 1 mm into the plate */
    translate([0, 0, thick - 1]) difference() {
      cube([panel_w, panel_d, rim_h - thick + 1]);
      translate([rim_t, rim_t, -2.5]) cube([panel_w - 2 * rim_t, panel_d - 2 * rim_t, rim_h - thick + 6]);
    }
  }
  /* hexagonal cells, point-up, cut right through the plate */
  for (row = [0 : rows - 1]) {
    for (col = [0 : columns - 1]) {
      translate([shift_x + col * pitch + (row % 2) * pitch / 2, shift_y + row * pitch * 0.866025, -2.5]) rotate([0, 0, 30]) cylinder(h = thick + 5, d = 2 * cell_r, $fn = 6);
    }
  }
  /* corner mounting holes, clear of the outer cell web */
  translate([4.2, 4.2, -2.5]) cylinder(h = thick + 5, d = mount_d);
  translate([57.17, 4.2, -2.5]) cylinder(h = thick + 5, d = mount_d);
  translate([4.2, 67.03, -2.5]) cylinder(h = thick + 5, d = mount_d);
  translate([57.17, 67.03, -2.5]) cylinder(h = thick + 5, d = mount_d);
}
