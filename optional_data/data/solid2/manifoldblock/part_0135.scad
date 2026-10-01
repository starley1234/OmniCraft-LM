$fn = 32;

// ----------------------------------------------------------------------
// Manifold block: gallery_top manifold
// ----------------------------------------------------------------------

// --- parameters (mm) ---
block_l = 80;             // block length, X
block_w = 50;             // block width, Y
block_h = 40;             // block height, Z
port_d = 10;              // port bore diameter
port_pitch = 24;          // port pitch along X
gallery_d = 16;           // top gallery width, Y
gallery_depth = 16;       // gallery pocket depth
wall_p = 8;               // gallery end wall thickness, X
mnt_d = 5;                // mounting hole diameter
mnt_in = 6;               // mounting hole inset from the edges

n_ports = 3;  // ports in the row
port_x0 = (block_l - (n_ports - 1) * port_pitch) / 2;  // first port X

difference() {
  cube([block_l, block_w, block_h]);
  for (i = [0 : n_ports - 1])
    translate([port_x0 + i * port_pitch, block_w / 2, -1])
      cylinder(h = block_h + 2, d = port_d);
  translate([wall_p, block_w / 2 - gallery_d / 2, block_h - gallery_depth])
    cube([block_l - 2 * wall_p, gallery_d, gallery_depth + 1]);
  for (cx = [mnt_in, block_l - mnt_in])
    for (cy = [mnt_in, block_w - mnt_in])
      translate([cx, cy, -1]) cylinder(h = block_h + 2, d = mnt_d);
}
