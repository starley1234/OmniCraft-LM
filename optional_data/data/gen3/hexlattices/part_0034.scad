$fn = 32;

// ----------------------------------------------------------------------
// Honeycomb panel: 84.76 x 50.96 mm, 15 cells of 12 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 84.76;          // panel width
panel_d = 50.96;          // panel depth
thick = 10;               // panel thickness
cell_r = 6;               // hex cell circumradius
pitch = 12.79;            // hex cell pitch (centre to centre)
web = 2.4;                // web between the cells
columns = 5;              // columns of cells
rows = 3;                 // rows of cells
cell_count = 15;          // total cells
shift_x = 13.6;           // first cell offset in x
shift_y = 14.4;           // first cell offset in y
mount_d = 5.4;            // corner mounting holes
hole_off = 4.2;           // mounting hole offset from the corners
rim_h = 14;               // rim height
rim_t = 4;                // rim wall thickness

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
  translate([80.56, 4.2, -2.5]) cylinder(h = thick + 5, d = mount_d);
  translate([4.2, 46.76, -2.5]) cylinder(h = thick + 5, d = mount_d);
  translate([80.56, 46.76, -2.5]) cylinder(h = thick + 5, d = mount_d);
}
