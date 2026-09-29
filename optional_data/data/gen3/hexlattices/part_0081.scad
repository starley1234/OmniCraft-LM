$fn = 32;

// ----------------------------------------------------------------------
// Honeycomb panel: 103.81 x 75.03 mm, 20 cells of 16 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 103.81;         // panel width
panel_d = 75.03;          // panel depth
thick = 5;                // panel thickness
cell_r = 8;               // hex cell circumradius
pitch = 16.26;            // hex cell pitch (centre to centre)
web = 2.4;                // web between the cells
columns = 5;              // columns of cells
rows = 4;                 // rows of cells
cell_count = 20;          // total cells
shift_x = 15.33;          // first cell offset in x
shift_y = 16.4;           // first cell offset in y
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
  translate([99.61, 4.2, -2.5]) cylinder(h = thick + 5, d = mount_d);
  translate([4.2, 70.83, -2.5]) cylinder(h = thick + 5, d = mount_d);
  translate([99.61, 70.83, -2.5]) cylinder(h = thick + 5, d = mount_d);
}
