$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 25, 14, 10 mm, 80 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 25;                  // step 1 diameter
len1 = 30;                // step 1 length
d2 = 14;                  // step 2 diameter
len2 = 10;                // step 2 length
d3 = 10;                  // step 3 diameter
len3 = 40;                // step 3 length
total = 80;               // overall length
chamfer = 1.5;            // end chamfer
groove_r = 7;             // groove radius
groove_z = 32;            // groove position from the end
groove_w = 3.5;           // groove width
groove_d = 2;             // groove depth
key_w = 5;                // keyway width
key_d = 2.5;              // keyway depth
key_len = 20;             // keyway length
key_z = 57;               // keyway start along the shaft

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [12.5 - chamfer, 0], [12.5, chamfer], [12.5, 30], [7, 30], [7, 40], [5, 40], [5, 78.5], [3.5, 80], [0, 80]];

difference() {
  rotate_extrude() polygon(profile);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 1, groove_w]);
  /* keyway milled into the top of the largest step */
  translate([d1 / 2 - key_d, -key_w / 2, key_z]) cube([key_d + 1, key_w, key_len]);
}
