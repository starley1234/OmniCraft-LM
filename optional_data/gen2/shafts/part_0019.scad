$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 40, 25, 14 mm, 95 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 40;                  // step 1 diameter
len1 = 40;                // step 1 length
d2 = 25;                  // step 2 diameter
len2 = 30;                // step 2 length
d3 = 14;                  // step 3 diameter
len3 = 25;                // step 3 length
total = 95;               // overall length
chamfer = 1;              // end chamfer
groove_r = 12.5;          // groove radius
groove_z = 42;            // groove position from the end
groove_w = 2;             // groove width
groove_d = 2;             // groove depth
key_w = 5;                // keyway width
key_d = 2.5;              // keyway depth
key_len = 34;             // keyway length
key_z = 58;               // keyway start along the shaft

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [20 - chamfer, 0], [20, chamfer], [20, 40], [12.5, 40], [12.5, 70], [7, 70], [7, 94], [6, 95], [0, 95]];

difference() {
  rotate_extrude() polygon(profile);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 1, groove_w]);
  /* keyway milled into the top of the largest step */
  translate([d1 / 2 - key_d, -key_w / 2, key_z]) cube([key_d + 1, key_w, key_len]);
}
