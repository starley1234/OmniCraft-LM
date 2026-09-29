$fn = 32;

// ----------------------------------------------------------------------
// Honeycomb panel: 71.96 x 62.03 mm, 16 cells of 12 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 71.96;          // panel width
panel_d = 62.03;          // panel depth
thick = 6;                // panel thickness
cell_r = 6;               // hex cell circumradius
pitch = 12.79;            // hex cell pitch (centre to centre)
web = 2.4;                // web between the cells
columns = 4;              // columns of cells
rows = 4;                 // rows of cells
cell_count = 16;          // total cells
shift_x = 13.6;           // first cell offset in x
shift_y = 14.4;           // first cell offset in y
mount_d = 5.4;            // corner mounting holes
hole_off = 4.2;           // mounting hole offset from the corners

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* hexagonal cells, point-up, cut right through the plate */
  for (row = [0 : rows - 1]) {
    for (col = [0 : columns - 1]) {
      translate([shift_x + col * pitch + (row % 2) * pitch / 2, shift_y + row * pitch * 0.866025, -2.5]) rotate([0, 0, 30]) cylinder(h = thick + 5, d = 2 * cell_r, $fn = 6);
    }
  }
  /* corner mounting holes, clear of the outer cell web */
  translate([4.2, 4.2, -2.5]) cylinder(h = thick + 5, d = mount_d);
  translate([67.76, 4.2, -2.5]) cylinder(h = thick + 5, d = mount_d);
  translate([4.2, 57.83, -2.5]) cylinder(h = thick + 5, d = mount_d);
  translate([67.76, 57.83, -2.5]) cylinder(h = thick + 5, d = mount_d);
}
