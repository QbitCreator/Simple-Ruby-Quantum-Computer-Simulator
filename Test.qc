ini_qbits(25)

#single-qubit gate test
i(0)
x(1)
h(2)
y(3)
z(4)
x(5)
s(5)
sd(6)
t(7)
td(8)
v(9)
vd(10)

#swap gate
swp(1,2)

#entanglement
x(1)
cx(1,11)

x(12)
x(13)
ccx(12,13,14)

#simple Deutsch-Josza algorithm
x(15)
h(15)
x(16)
h(16)

cx(16,15)

h(15)
h(16)

#controlled hadamard
ch(2,17)

#controlled z test
h(0)
cz(2,0)

#multiple entanglement test
h(19)
cx(19,20)
cx(20,22)

#negative entanglement
h(23)
x(24)
cx(23,24)


