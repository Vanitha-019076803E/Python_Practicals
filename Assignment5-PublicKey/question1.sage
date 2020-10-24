
from sage.all import *
"""
RSA key generation....Modulus N and private keys,public and private exponents produced from key generation is
used for signature generation of RSA using Chinese Remainder Theorem
"""
def keyGen(n=256):
    "Generates an RSA key"
    while True:
        p = random_prime(2 ^ (n // 2));
        q = random_prime(2 ^ (n // 2));
        e = 3
        if gcd(e, (p - 1) * (q - 1)) == 1: break
    d = inverse_mod(e, (p - 1) * (q - 1))
    Nn = p * q
    print("p=", p, "q=", q)
    print("N=", Nn)
    print("Size of N:", Nn.nbits())
    return Nn, p, q, e, d

"""
signature generation of RSA using CRT by computing sp and sq
"""
def signatureGen(m):
    Nn, p, q, e, d =keyGen()
    sp = m.powermod(d.mod(p - 1), p)
    sq = m.powermod(d.mod(q - 1), q)
    s= CRT(sp, sq, p, q)
    s1= m.powermod(d,Nn)
    print("Signature using CRT = " +str(s))
    print("Signature using normal method =" +str(s1))
    print("Signature generated by CRT and normal method is equal = "+str(s==s1))
    return s

if __name__ == "__main__":
    message = 1234556778
    s = signatureGen(message)


