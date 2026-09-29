$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 40, 16, 8 mm, 100 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 40;                  // step 1 diameter
len1 = 30;                // step 1 length
d2 = 16;                  // step 2 diameter
len2 = 30;                // step 2 length
d3 = 8;                   // step 3 diameter
len3 = 40;                // step 3 length
total = 100;              // overall length
chamfer = 1.5;            // end chamfer
groove_r = 8;             // groove radius
groove_z = 32;            // groove position from the end
groove_w = 3;             // groove width
groove_d = 1.6;           // groove depth
key_w = 5;                // keyway width
key_d = 2.5;              // keyway depth
key_len = 24;             // keyway length
key_z = 73;               // keyway start along the shaft
cross_d = 5;              // cross pin hole
cross_z = 80;             // cross hole position

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [20 - chamfer, 0], [20, chamfer], [20, 30], [8, 30], [8, 60], [4, 60], [4, 98.5], [2.5, 100], [0, 100]];

difference() {
  rotate_extrude() polygon(profile);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 1, groove_w]);
  /* keyway milled into the top of the largest step */
  translate([d1 / 2 - key_d, -key_w / 2, key_z]) cube([key_d + 1, key_w, key_len]);
  /* cross pin hole through the small step */
  translate([0, 0, cross_z]) rotate([90, 0, 0]) cylinder(h = d3 + 4, d = cross_d, center = true);
}
