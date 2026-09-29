$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 30, 16, 12, 10 mm, 125 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 30;                  // step 1 diameter
len1 = 25;                // step 1 length
d2 = 16;                  // step 2 diameter
len2 = 30;                // step 2 length
d3 = 12;                  // step 3 diameter
len3 = 30;                // step 3 length
d4 = 10;                  // step 4 diameter
len4 = 40;                // step 4 length
total = 125;              // overall length
chamfer = 1.5;            // end chamfer
groove_r = 6;             // groove radius
groove_z = 57;            // groove position from the end
groove_w = 2;             // groove width
groove_d = 1.3;           // groove depth
key_w = 8;                // keyway width
key_d = 4;                // keyway depth
key_len = 19;             // keyway length
key_z = 103;              // keyway start along the shaft
cross_d = 7;              // cross pin hole
cross_z = 105;            // cross hole position

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [15 - chamfer, 0], [15, chamfer], [15, 25], [8, 25], [8, 55], [6, 55], [6, 85], [5, 85], [5, 123.5], [3.5, 125], [0, 125]];

difference() {
  rotate_extrude() polygon(profile);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 1, groove_w]);
  /* keyway milled into the top of the largest step */
  translate([d1 / 2 - key_d, -key_w / 2, key_z]) cube([key_d + 1, key_w, key_len]);
  /* cross pin hole through the small step */
  translate([0, 0, cross_z]) rotate([90, 0, 0]) cylinder(h = d4 + 4, d = cross_d, center = true);
}
