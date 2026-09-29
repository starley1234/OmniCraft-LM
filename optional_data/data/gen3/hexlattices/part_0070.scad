$fn = 32;

// ----------------------------------------------------------------------
// Honeycomb panel: 86.15 x 74 mm, 16 cells of 16 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 86.15;          // panel width
panel_d = 74;             // panel depth
thick = 8;                // panel thickness
cell_r = 8;               // hex cell circumradius
pitch = 15.86;            // hex cell pitch (centre to centre)
web = 2;                  // web between the cells
columns = 4;              // columns of cells
rows = 4;                 // rows of cells
cell_count = 16;          // total cells
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
  translate([81.95, 4.2, -2.5]) cylinder(h = thick + 5, d = mount_d);
  translate([4.2, 69.8, -2.5]) cylinder(h = thick + 5, d = mount_d);
  translate([81.95, 69.8, -2.5]) cylinder(h = thick + 5, d = mount_d);
}
