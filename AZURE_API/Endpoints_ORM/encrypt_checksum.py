#Criptografia de encriptacion
import base64
import hashlib
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
from cryptography.hazmat.primitives import padding
from cryptography.hazmat.backends import default_backend
import os
#contrasena que pongo para que pueda tener 32 bytes
password = b"miPasswordSeguro123"

# Deriva clave AES-256 de 32 bytes
key = hashlib.sha256(password).digest()  # 32 bytes

def encrypt_checksum(*args) -> str:
    """
    Recibe n strings, los concatena, genera SHA256, cifra con AES-256-CBC y devuelve base64.
    """
    #Concatena los datos en string 
    concat_data = ''.join(str(arg) for arg in args)
    #Calcula el hash SHA256
    hash_bytes = hashlib.sha256(concat_data.encode('utf-8')).digest()

    #Padding para AES CBC
    padder = padding.PKCS7(128).padder()
    padded_data = padder.update(hash_bytes) + padder.finalize()

    #Generar IV aleatorio (16 bytes)
    iv = os.urandom(16)

    #Cifra con AES-256 CBC el cual es utilizado como algoritmo de encriptacion
    cipher = Cipher(algorithms.AES(key), modes.CBC(iv), backend=default_backend())
    encryptor = cipher.encryptor()
    encrypted = encryptor.update(padded_data) + encryptor.finalize()

    #Concatenar IV + ciphertext (para usar en desencriptado) en este caso no es necesario ya que es insercion de datos la mayoria 
    iv_encrypted = iv + encrypted

    #Codificar en base64 para almacenar como texto en la base de datos
    checksum_b64 = base64.b64encode(iv_encrypted).decode('utf-8')

    return checksum_b64