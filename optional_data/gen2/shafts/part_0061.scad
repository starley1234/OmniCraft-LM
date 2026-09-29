$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 50, 30, 25, 16, 8 mm, 130 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 50;                  // step 1 diameter
len1 = 20;                // step 1 length
d2 = 30;                  // step 2 diameter
len2 = 10;                // step 2 length
d3 = 25;                  // step 3 diameter
len3 = 30;                // step 3 length
d4 = 16;                  // step 4 diameter
len4 = 40;                // step 4 length
d5 = 8;                   // step 5 diameter
len5 = 30;                // step 5 length
total = 130;              // overall length
chamfer = 2;              // end chamfer
key_w = 4;                // keyway width
key_d = 2;                // keyway depth
key_len = 14;             // keyway length
key_z = 113;              // keyway start along the shaft
cross_d = 5;              // cross pin hole
cross_z = 115;            // cross hole position

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [25 - chamfer, 0], [25, chamfer], [25, 20], [15, 20], [15, 30], [12.5, 30], [12.5, 60], [8, 60], [8, 100], [4, 100], [4, 128], [2, 130], [0, 130]];

difference() {
  rotate_extrude() polygon(profile);
  /* keyway milled into the top of the largest step */
  translate([d1 / 2 - key_d, -key_w / 2, key_z]) cube([key_d + 1, key_w, key_len]);
  /* cross pin hole through the small step */
  translate([0, 0, cross_z]) rotate([90, 0, 0]) cylinder(h = d5 + 4, d = cross_d, center = true);
}
