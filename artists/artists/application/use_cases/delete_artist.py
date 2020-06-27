from artists.artists.application.repositories.repository_artist import ArtistRepository
from artists.artists.domain.exceptions import DataBaseException, ArtistNotExistsException, ArtistInvalidException
from artists.artists.domain.artist import Artist
from artists.artists.application.use_cases import exists_artist
from dataclasses import dataclass


@dataclass
class DeleteArtistInputDto:
    idArtist: str = None


class DeleteArtist:
    def __init__(self, repository: ArtistRepository):
        self.repository = repository

    def execute(self, inputArtist: DeleteArtistInputDto):
        if not inputArtist.idArtist:
            raise ArtistInvalidException("Empty fields")

        usecase_exists_artist = exists_artist.ExistsArtist(self.repository)
        dtoclass = exists_artist.ExistsArtistInputDto(inputArtist.idArtist)
        usecase_exists_artist.execute(dtoclass)

        try:
            result = self.repository.delete(inputArtist.idArtist)
            return result
        except DataBaseException as ex:
            raise DataBaseException(ex)
        